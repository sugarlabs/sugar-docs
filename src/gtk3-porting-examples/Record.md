**Replace:**

def getStringFromPixbuf(pixbuf):

`   data = [""]`\
`   pixbuf.save_to_callback(_saveDataToBufferCb, `“`png`”`, {}, data)`\
`   return base64.b64encode(str(data[0]))`

def \_saveDataToBufferCb(buf, data):

`   data[0] += buf`\
`   return True`

**By:**

def getStringFromPixbuf(pixbuf):

`   `“““`Converts`` ``a`` ``pixbuf`` ``in`` ``a`` ``string.`”””\
`   `\
`   # Save_to_bufferv return: (bool, string)`\
`   data = pixbuf.save_to_bufferv('png', [], [])`\
`   `\
`   return base64.b64encode(data[1])`

**Replace:**

thumbImg.save(thumbPath, “jpeg”, {“quality”:“85”} )

**By:**

thumbImg.savev(thumbPath, “jpeg”, {“quality”:“85”} )

**Replace:**

def load\_colored\_svg(filename, stroke, fill):

`   path = os.path.join(constants.GFX_PATH, filename)`\
`   data = open(path, 'r').read()`

`   entity = '`

<!ENTITY fill_color "%s">
' % fill

`   data = re.sub('`

<!ENTITY fill_color .*>
', entity, data)

`   entity = '`

<!ENTITY stroke_color "%s">
' % stroke

`   data = re.sub('`

<!ENTITY stroke_color .*>
', entity, data)

`   return rsvg.Handle(data=data).get_pixbuf()`

**By:**

def load\_colored\_svg(filename, stroke, fill):

`   `“`"`”`Loads an svg, will change the fill and`\
`   stroke colors and returns the pixbuf.`“`"`”\
`   `\
`   path = os.path.join(constants.GFX_PATH, filename)`\
`   data = open(path, 'r').read()`

`   entity = '`

<!ENTITY fill_color "%s">
' % fill

`   data = re.sub('`

<!ENTITY fill_color .*>
', entity, data)

`   entity = '`

<!ENTITY stroke_color "%s">
' % stroke

`   data = re.sub('`

<!ENTITY stroke_color .*>
', entity, data)

`   return Rsvg.Handle.new_from_data(data.encode('utf-8')).get_pixbuf()`

**Not implement:**

super(Record, self).close()

**Due to:** [1](http://bugs.sugarlabs.org/ticket/4345)

When an application fails and you want to close from the corresponding
button occurs:

Traceback (most recent call last): File
“/usr/lib/python2.7/site-packages/sugar3/activity/activity.py”, line
890, in \_keep\_failed\_dialog\_response\_cb self.close(skip\_save=True)
TypeError: close() got an unexpected keyword argument 'skip\_save' And
the activity is not closed, nor can restart sugar as alert reappears
again and again, you need to stop.

This error is caused by the following: When a class B inherits from
class A, and in B is overwritten a function of A, A function is no
longer running, but instead runs the function of the class B, even when
explicitly call function A from B.

**Stop using Pixmap instead use Pixbuf:**

**Replace:**

`   def _generate_image(self, num):`\
`       w = 55`\
`       h = w`\
`       pixmap = gdk.Pixmap(self.get_window(), w, h, -1)`\
`       ctx = pixmap.cairo_create()`\
`       ctx.rectangle(0, 0, w, h)`\
`       ctx.set_source_rgb(0, 0, 0)`\
`       ctx.fill()`

**By:**

`   def _generate_image(self, num):`

`       w = 55`\
`       h = w`\
`       `\
`       x, y = self.get_property('window').get_position()`\
`       rect = self.get_allocation()`\
`       width, height = rect.width, rect.height`\
`      `\
`       thumb_surface = Gdk.Window.create_similar_surface(`\
`           self.get_property('window'),`\
`           cairo.CONTENT_COLOR,`\
`           width, height)`\
`      `\
`       ctx = cairo.Context(thumb_surface)`\
`       `\
`       Gdk.cairo_set_source_window(`\
`           cairo_context,`\
`           self.get_property('window'),`\
`           x, y)`\
`           `\
`       ctx.paint()`\
`       `\
`       ctx.rectangle(x, y, w, h)`\
`       ctx.set_source_rgb(0, 0, 0)`\
`       ctx.fill()`

'''New Gst.TagList:

Replace:'''

`       taglist = self._get_tags(constants.TYPE_AUDIO)`

`       if self._audio_pixbuf:`\
`           pixbuf_b64 = utils.getStringFromPixbuf(self._audio_pixbuf)`\
`           taglist[gst.TAG_EXTENDED_COMMENT] = `“`coverart=`”` + pixbuf_b64`

`       vorbis_enc = audioline.get_by_name('audioVorbisenc')`\
`       vorbis_enc.merge_tags(taglist, gst.TAG_MERGE_REPLACE_ALL)`

**By:**

`       taglist = self._get_tags(constants.TYPE_AUDIO)`\
`       `\
`       if self._audio_pixbuf:`\
`           pixbuf_b64 = utils.getStringFromPixbuf(self._audio_pixbuf)`\
`           `\
`           taglist.add_value(`\
`               Gst.TagMergeMode.REPLACE,`\
`               Gst.TAG_EXTENDED_COMMENT,`\
`               `“`coverart=`”` + pixbuf_b64)`\
`               `\
`       vorbis_enc = audioline.get_by_name('audioVorbisenc')`\
`       vorbis_enc.merge_tags(taglist, Gst.TagMergeMode.REPLACE_ALL)`

**Replace:**

`       taglist = self._get_tags(constants.TYPE_VIDEO)`\
`       vorbis_enc = muxline.get_by_name('muxVorbisenc')`\
`       vorbis_enc.merge_tags(taglist, gst.TAG_MERGE_REPLACE_ALL)`

**By:**

`       taglist = self._get_tags(constants.TYPE_VIDEO)`\
`       vorbis_enc = muxline.get_by_name('muxVorbisenc')`\
`       vorbis_enc.merge_tags(taglist, Gst.TagMergeMode.REPLACE_ALL)`

**Replace:**

`   def _get_tags(self, type):`

`       tl = gst.TagList()`\
`       tl[gst.TAG_ARTIST] = self.model.get_nickname()`\
`       tl[gst.TAG_COMMENT] = `“`olpc`”\
`       tl[gst.TAG_ALBUM] = `“`olpc`”\
`       tl[gst.TAG_DATE] = utils.getDateString(int(time.time()))`\
`       stringType = constants.MEDIA_INFO[type]['istr']`\
`       `\
`       tl[gst.TAG_TITLE] = _('%(type)s by %(name)s') % {'type': stringType,`\
`               'name': self.model.get_nickname()}`\
`       return tl`

**By:**

`   def _get_tags(self, type):`\
`       `\
`       taglist = Gst.TagList.new_empty()`\
`       `\
`       taglist.add_value(`\
`           Gst.TagMergeMode.REPLACE,`\
`           Gst.TAG_ARTIST,`\
`           self.model.get_nickname())`\
`           `\
`       taglist.add_value(`\
`           Gst.TagMergeMode.REPLACE,`\
`           Gst.TAG_COMMENT,`\
`           `“`olpc`”`)`

`       taglist.add_value(`\
`           Gst.TagMergeMode.REPLACE,`\
`           Gst.TAG_ALBUM,`\
`           `“`olpc`”`) #self.ca.metadata['title']`

`       taglist.add_value(`\
`           Gst.TagMergeMode.REPLACE,`\
`           Gst.TAG_DATE,`\
`           utils.getDateString(int(time.time())))`\
`           `\
`       stringType = constants.MEDIA_INFO[type]['istr']`\
`           `\
`       taglist.add_value(`\
`           Gst.TagMergeMode.REPLACE,`\
`           Gst.TAG_TITLE,`\
`           _('%(type)s by %(name)s') % {'type': stringType,`\
`               'name': self.model.get_nickname()})`\
`               `\
`       return taglist`

GObject.get\_data() and set\_data() are deprecated. Use normal Python
attributes instead button.set\_data('handler-ids', (clicked\_handler,
remove\_handler, clipboard\_handler))

**No joint implementation:**

self.connect('size\_allocate', self.\_size\_allocate\_cb) def
\_size\_allocate\_cb(self, widget, requisition): . . .

`and`

def do\_size\_allocate(self, allocation): . . .

**Replace:**

taglist.add\_value(

`      Gst.TagMergeMode.REPLACE, `\
`      Gst.TAG_DATE, `\
`      utils.getDateString(int(time.time()))) `

def getDateString( when ):

`   return strftime( `“`%c`”`, time.localtime(when) )`

**By:**

datetime = GLib.DateTime.new\_now\_local() date = GLib.Date()
date.set\_day(datetime.get\_day\_of\_month())
date.set\_month(datetime.get\_month())
date.set\_year(datetime.get\_year())

taglist.add\_value(

`     Gst.TagMergeMode.REPLACE,`\
`     Gst.TAG_DATE,`\
`     date)`
