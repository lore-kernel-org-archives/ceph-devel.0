From: Mike Christie <mchristi@redhat.com>
Subject: [PATCH 0/18] lio rbd support
Date: Wed, 29 Jul 2015 04:28:02 -0500
Message-ID: <55B89CA2.1050807@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040000030003060908090701"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbbG2J2E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:28:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> Ceph Development" <ceph-devel@vger.kernel.org>, "target-devel@vger.kernel.org >> target-devel" <target-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040000030003060908090701
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The following patches implement a LIO RBD backend. Instead of having LIO
send bios/requests through the block layer and having rbd translate them
to ceph/rados requests, this implements a LIO RBD backend module that
translates LIO se_cmds directly to ceph/rados requests.

This patchset also implements native ceph/rados support for WRITE_SAME
and COMPARE_AND_WRITE commands. We execute them on the OSD similar to
how we execute UNMAP/TRIM/DISCARD requests.

This patchset just only implements single node support. The cluster
support will be posted soon. I am currently redoing my patches against
Doug's locking API and redoing my PR hooks.


The patches were made over linus's tree pulled today
(last commit 956325bd55bb020e574129c443a2c2c66a8316e7), plus Nick's
target-pending tree (last commit 7a14e3c1cfcbdf377098542ba440e1ebb0eeafa4),
and Doug's wip-djf-watch-notify2 branch in the ceph client tree which
can be found here https://github.com/ceph/ceph-client.

Attached at the patches for rtslib and targetlci to be able to use the
rbd module. It was made over Andy's fb branch.

--------------040000030003060908090701
Content-Type: text/x-patch;
 name="targetcli-fb-rbd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="targetcli-fb-rbd.patch"

diff -aurp targetcli-fb-2.1.fb41/targetcli/ui_backstore.py targetcli-fb-2.1.fb41.work/targetcli/ui_backstore.py
--- targetcli-fb-2.1.fb41/targetcli/ui_backstore.py	2015-06-23 11:23:34.000000000 -0500
+++ targetcli-fb-2.1.fb41.work/targetcli/ui_backstore.py	2015-07-29 02:55:51.305430180 -0500
@@ -109,6 +109,7 @@ class UIBackstores(UINode):
         UIRDMCPBackstore(self)
         UIFileIOBackstore(self)
         UIBlockBackstore(self)
+        UIRBDBackstore(self)
         UIUserBackedBackstore(self)
 
 
@@ -402,6 +403,41 @@ class UIBlockBackstore(UIBackstore):
             completions = [completions[0] + ' ']
         return completions
 
+class UIRBDBackstore(UIBackstore):
+    '''
+    RBD backstore UI.
+    '''
+    def __init__(self, parent):
+        self.so_cls = UIRBDStorageObject
+        UIBackstore.__init__(self, 'rbd', parent)
+
+    def ui_command_create(self, name, dev, readonly=None):
+        '''
+        Creates an RBD Storage object. I{dev} is the path to the RBD
+        block device to use.
+        '''
+        self.assert_root()
+
+        readonly = self.ui_eval_param(readonly, 'bool', False)
+
+        so = RBDStorageObject(name, dev, readonly=readonly)
+        ui_so = UIRBDStorageObject(so, self)
+        self.setup_model_alias(so)
+        self.shell.log.info("Created RBD storage object %s using %s."
+                            % (name, dev))
+        return self.new_node(ui_so)
+
+    def ui_complete_create(self, parameters, text, current_param):
+        '''
+        Auto-completes the device name
+        '''
+        if current_param != 'dev':
+            return []
+        completions = complete_path(text, stat.S_ISBLK)
+        if len(completions) == 1 and not completions[0].endswith('/'):
+            completions = [completions[0] + ' ']
+        return completions
+
 
 class UIUserBackedBackstore(UIBackstore):
     '''
@@ -543,6 +579,21 @@ class UIBlockStorageObject(UIStorageObje
         return ("%s (%s) %s%s %s" % (so.udev_path, bytes_to_human(so.size),
                                    ro_str, wb_str, so.status), True)
 
+class UIRBDStorageObject(UIStorageObject):
+    def summary(self):
+        so = self.rtsnode
+
+        if so.write_back:
+            wb_str = "write-back"
+        else:
+            wb_str = "write-thru"
+
+        ro_str = ""
+        if so.readonly:
+            ro_str = "ro "
+
+        return ("%s (%s) %s%s %s" % (so.udev_path, bytes_to_human(so.size),
+                                   ro_str, wb_str, so.status), True)
 
 class UIUserBackedStorageObject(UIStorageObject):
     def summary(self):

--------------040000030003060908090701
Content-Type: text/x-patch;
 name="rtslib-fb-rbd-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rtslib-fb-rbd-support.patch"

diff -aurp rtslib-fb-2.1.fb57/rtslib/tcm.py rtslib-fb-2.1.fb57.work/rtslib/tcm.py
--- rtslib-fb-2.1.fb57/rtslib/tcm.py	2015-06-23 11:21:11.000000000 -0500
+++ rtslib-fb-2.1.fb57.work/rtslib/tcm.py	2015-07-29 02:58:24.882204555 -0500
@@ -735,6 +734,107 @@ class BlockStorageObject(StorageObject):
         d['dev'] = self.udev_path
         return d
 
+class RBDStorageObject(StorageObject):
+    '''
+    An interface to configFS storage objects for RBD backstore.
+    '''
+
+    # RBDStorageObject private stuff
+
+    def __init__(self, name, dev=None, wwn=None, readonly=False,
+                 write_back=False):
+        '''
+        A RBDIOStorageObject can be instantiated in two ways:
+            - B{Creation mode}: If I{dev} is specified, the underlying configFS
+              object will be created with that parameter.
+              No RBDIOStorageObject with the same I{name} can pre-exist in
+              the parent Backstore in that mode.
+            - B{Lookup mode}: If I{dev} is not set, then the
+              RBDIOStorageObject will be bound to the existing configFS
+              object in the parent Backstore having the specified
+              I{name}. The underlying configFS object must already exist in
+              that mode, or instantiation will fail.
+
+        @param name: The name of the RBDIOStorageObject.
+        @type name: string
+        @param dev: The path to the backend rbd device to be used.
+            - Example: I{dev="/dev/sda"}.
+            - The only device type that is accepted I{TYPE_DISK}.
+              For other device types, use pscsi.
+        @type dev: string
+        @param wwn: T10 WWN Unit Serial, will generate if None
+        @type wwn: string
+        @return: A RBDIOStorageObject object.
+        '''
+
+        if dev is not None:
+            super(RBDStorageObject, self).__init__(name, 'create')
+            try:
+                self._configure(dev, wwn, readonly)
+            except:
+                self.delete()
+                raise
+        else:
+            super(RBDStorageObject, self).__init__(name, 'lookup')
+
+    def _configure(self, dev, wwn, readonly):
+        self._check_self()
+        if get_blockdev_type(dev) != 0:
+            raise RTSLibError("Device %s is not a TYPE_DISK rbd device" % dev)
+        if is_dev_in_use(dev):
+            raise RTSLibError("Cannot configure StorageObject because "
+                              + "device %s is already in use" % dev)
+        self._set_udev_path(dev)
+        self._control("udev_path=%s" % dev)
+        self._control("readonly=%d" % readonly)
+        self._enable()
+
+        super(RBDStorageObject, self)._configure(wwn)
+
+    def _get_major(self):
+        self._check_self()
+        return int(self._parse_info('Major'))
+
+    def _get_minor(self):
+        self._check_self()
+        return int(self._parse_info('Minor'))
+
+    def _get_size(self):
+        # udev_path doesn't work here, what if LV gets renamed?
+        return get_size_for_disk_name(self._parse_info('device')) * int(self._parse_info('SectorSize'))
+
+    def _get_wb_enabled(self):
+        self._check_self()
+        return bool(int(self.get_attribute("emulate_write_cache")))
+
+    def _get_readonly(self):
+        self._check_self()
+        # 'readonly' not present before kernel 3.6
+        try:
+            return bool(int(self._parse_info('readonly')))
+        except AttributeError:
+            return False
+
+    # RBDStorageObject public stuff
+
+    major = property(_get_major,
+            doc="Get the block device major number")
+    minor = property(_get_minor,
+            doc="Get the block device minor number")
+    size = property(_get_size,
+            doc="Get the block device size")
+    write_back = property(_get_wb_enabled,
+            doc="True if write-back, False if write-through (write cache disabled)")
+    readonly = property(_get_readonly,
+            doc="True if the device is read-only, False if read/write")
+
+    def dump(self):
+        d = super(RBDStorageObject, self).dump()
+        d['write_back'] = self.write_back
+        d['readonly'] = self.readonly
+        d['wwn'] = self.wwn
+        d['dev'] = self.udev_path
+        return d
 
 class UserBackedStorageObject(StorageObject):
     '''
@@ -850,6 +950,7 @@ so_mapping = {
     "fileio": FileIOStorageObject,
     "iblock": BlockStorageObject,
     "block": BlockStorageObject,
+    "rbd": RBDStorageObject,
     "user": UserBackedStorageObject,
 }
 
@@ -860,6 +961,7 @@ bs_params = {
     FileIOStorageObject: dict(name='fileio'),
     BlockStorageObject: dict(name='block', alt_dirprefix='iblock'),
     UserBackedStorageObject: dict(name='user'),
+    RBDStorageObject: dict(name='rbd'),
     }
 
 bs_cache = {}

--------------040000030003060908090701--
