From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 20 Aug 2013 21:09:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308202107540.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-202630702-1377058138=:1479"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37954 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3HUEJa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 00:09:30 -0400
Content-ID: <alpine.DEB.2.00.1308202109260.1479@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zheng.z.yan@intel.com
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-202630702-1377058138=:1479
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1308202109261.1479@cobra.newdream.net>

Coverity picked up some issues with the filestore code.  These are mostly 
old issues that appear new becuase code moved around, but this is probably 
a good opportunity to fix them... :)

sage
--557981400-202630702-1377058138=:1479
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1308202107541.1479@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: INLINE

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 8DB858004F
	for <sage@cobra.newdream.net>; Tue, 20 Aug 2013 19:49:39 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id 1023612064D; Tue, 20 Aug 2013 20:01:25 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcahe.dreamhost.com
	[208.97.132.74])
	by destro.newdream.net (Postfix) with ESMTP id 0E8D8120253
	for <sage@newdream.net>; Tue, 20 Aug 2013 20:01:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id 7B912FD7321
	for <sage@newdream.net>; Tue, 20 Aug 2013 19:49:39 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from godfather.dreamhost.com ([208.97.132.81])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id QXWKl3SzX0B8 for <sage@newdream.net>;
	Tue, 20 Aug 2013 19:49:39 -0700 (PDT)
Received: from build-l3.scan.coverity.com (unknown [208.69.177.216])
	by godfather.dreamhost.com (Postfix) with ESMTP id 3B02D1B0059
	for <sage@newdream.net>; Tue, 20 Aug 2013 19:49:39 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=build-l3.scan.coverity.com)
	by build-l3.scan.coverity.com with esmtp (Exim 4.69)
	(envelope-from <scan-admin@coverity.com>)
	id 1VByUM-0004JM-Ih; Tue, 20 Aug 2013 19:49:38 -0700
From: scan-admin@coverity.com
To: sage@newdream.net
CC: 
Subject: New Defects reported by Coverity Scan for ceph
Message-Id: <E1VByUM-0004JM-Ih@build-l3.scan.coverity.com>
Date: Tue, 20 Aug 2013 19:49:38 -0700
X-Spambayes-Classification: ham; 0.00



Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan

Defect(s) Reported-by: Coverity Scan
Showing 7 of 9 defects
	
** CID 1063704: Uninitialized scalar field (UNINIT_CTOR)
/os/BtrfsFileStoreBackend.cc: 57

** CID 1063703: Time of check time of use (TOCTOU)
/os/GenericFileStoreBackend.cc: 170

** CID 1063702: Time of check time of use (TOCTOU)
/os/BtrfsFileStoreBackend.cc: 246

** CID 1063701: Copy into fixed size buffer (STRING_OVERFLOW)
/os/BtrfsFileStoreBackend.cc: 458

** CID 1063700: Copy into fixed size buffer (STRING_OVERFLOW)
/os/BtrfsFileStoreBackend.cc: 370

** CID 1063699: Resource leak (RESOURCE_LEAK)
/os/BtrfsFileStoreBackend.cc: 345

** CID 1063698: Improper use of negative value (NEGATIVE_RETURNS)


________________________________________________________________________
CID 1063704: Uninitialized scalar field (UNINIT_CTOR)

/os/BtrfsFileStoreBackend.h: 25 ( member_decl)
   22    private:
   23      bool has_clone_range;       ///< clone range ioctl is supported
   24      bool has_snap_create;       ///< snap create ioctl is supported
>>> Class member declaration for "has_snap_destroy".
   25      bool has_snap_destroy;      ///< snap destroy ioctl is supported
   26      bool has_snap_create_v2;    ///< snap create v2 ioctl (async!) is supported
   27      bool has_wait_sync;         ///< wait sync ioctl is supported
   28      bool stable_commits;
   29      bool m_filestore_btrfs_clone_range;
  

/os/BtrfsFileStoreBackend.cc: 57 ( uninit_member)
   54        GenericFileStoreBackend(fs), has_clone_range(false), has_snap_create(false),
   55        has_snap_create_v2(false), has_wait_sync(false), stable_commits(false),
   56        m_filestore_btrfs_clone_range(g_conf->filestore_btrfs_clone_range),
>>> CID 1063704: Uninitialized scalar field (UNINIT_CTOR)
>>> Non-static class member "has_snap_destroy" is not initialized in this constructor nor in any functions that it calls.
   57        m_filestore_btrfs_snap (g_conf->filestore_btrfs_snap) { }
   58    
   59    int BtrfsFileStoreBackend::detect_features()
   60    {
   61      int r;
  
________________________________________________________________________
CID 1063703: Time of check time of use (TOCTOU)

/os/GenericFileStoreBackend.cc: 170 ( fs_check_call)
   167    int GenericFileStoreBackend::create_current()
   168    {
   169      struct stat st;
>>> CID 1063703: Time of check time of use (TOCTOU)
>>> Calling function "stat(char const *, stat *)" to perform check on "this->get_current_path()->c_str()".
   170      int ret = ::stat(get_current_path().c_str(), &st);
   171      if (ret == 0) {
   172        // current/ exists
   173        if (!S_ISDIR(st.st_mode)) {
   174          dout(0) << "_create_current: current/ exists but is not a directory" << dendl;
  

/os/GenericFileStoreBackend.cc: 178 ( toctou)
   175          ret = -EINVAL;
   176        }
   177      } else {
>>> Calling function "mkdir(char const *, __mode_t)" that uses "this->get_current_path()->c_str()" after a check function. This can cause a time-of-check, time-of-use race condition.
   178        ret = ::mkdir(get_current_path().c_str(), 0755);
   179        if (ret < 0) {
   180          ret = -errno;
   181          dout(0) << "_create_current: mkdir " << get_current_path() << " failed: "<< cpp_strerror(ret) << dendl;
   182        }
  
________________________________________________________________________
CID 1063702: Time of check time of use (TOCTOU)

/os/BtrfsFileStoreBackend.cc: 246 ( fs_check_call)
   243    int BtrfsFileStoreBackend::create_current()
   244    {
   245      struct stat st;
>>> CID 1063702: Time of check time of use (TOCTOU)
>>> Calling function "stat(char const *, stat *)" to perform check on "this->get_current_path()->c_str()".
   246      int ret = ::stat(get_current_path().c_str(), &st);
   247      if (ret == 0) {
   248        // current/ exists
   249        if (!S_ISDIR(st.st_mode)) {
   250          dout(0) << "create_current: current/ exists but is not a directory" << dendl;
  

/os/BtrfsFileStoreBackend.cc: 288 ( toctou)
   285      }
   286    
   287      dout(2) << "create_current: created btrfs subvol " << get_current_path() << dendl;
>>> Calling function "chmod(char const *, __mode_t)" that uses "this->get_current_path()->c_str()" after a check function. This can cause a time-of-check, time-of-use race condition.
   288      if (::chmod(get_current_path().c_str(), 0755) < 0) {
   289        ret = -errno;
   290        dout(0) << "create_current: failed to chmod " << get_current_path() << " to 0755: "
   291    	    << cpp_strerror(ret) << dendl;
   292        return ret;
  
________________________________________________________________________
CID 1063701: Copy into fixed size buffer (STRING_OVERFLOW)

/os/BtrfsFileStoreBackend.cc: 458 ( fixed_size_dest)
   455      btrfs_ioctl_vol_args vol_args;
   456      memset(&vol_args, 0, sizeof(vol_args));
   457      vol_args.fd = 0;
>>> CID 1063701: Copy into fixed size buffer (STRING_OVERFLOW)
>>> You might overrun the 4088 byte fixed-size string "vol_args.name" by copying the return value of "std::basic_string<char, std::char_traits<char>, std::allocator<char> >::c_str() const" without checking the length.
   458      strcpy(vol_args.name, name.c_str());
   459    
   460      int ret = ::ioctl(get_basedir_fd(), BTRFS_IOC_SNAP_DESTROY, &vol_args);
   461      if (ret) {
   462        ret = -errno;
  
________________________________________________________________________
CID 1063700: Copy into fixed size buffer (STRING_OVERFLOW)

/os/BtrfsFileStoreBackend.cc: 370 ( fixed_size_dest)
   367        memset(&async_args, 0, sizeof(async_args));
   368        async_args.fd = get_current_fd();
   369        async_args.flags = BTRFS_SUBVOL_CREATE_ASYNC;
>>> CID 1063700: Copy into fixed size buffer (STRING_OVERFLOW)
>>> You might overrun the 4040 byte fixed-size string "async_args.name" by copying the return value of "std::basic_string<char, std::char_traits<char>, std::allocator<char> >::c_str() const" without checking the length.
   370        strcpy(async_args.name, name.c_str());
   371    
   372        int r = ::ioctl(get_basedir_fd(), BTRFS_IOC_SNAP_CREATE_V2, &async_args);
   373        if (r < 0) {
   374          r = -errno;
  
________________________________________________________________________
CID 1063699: Resource leak (RESOURCE_LEAK)

/os/BtrfsFileStoreBackend.cc: 310 ( alloc_fn)
   307      }
   308    
   309      // get snap list
>>> Storage is returned from allocation function "opendir(char const *)".
   310      DIR *dir = ::opendir(get_basedir_path().c_str());
   311      if (!dir) {
   312        ret = -errno;
   313        dout(0) << "list_checkpoints: opendir '" << get_basedir_path() << "' failed: "
   314    	    << cpp_strerror(ret) << dendl;
  

/os/BtrfsFileStoreBackend.cc: 310 ( var_assign)
   307      }
   308    
   309      // get snap list
>>> Assigning: "dir" = storage returned from "opendir(this->get_basedir_path()->c_str())".
   310      DIR *dir = ::opendir(get_basedir_path().c_str());
   311      if (!dir) {
   312        ret = -errno;
   313        dout(0) << "list_checkpoints: opendir '" << get_basedir_path() << "' failed: "
   314    	    << cpp_strerror(ret) << dendl;
  

/os/BtrfsFileStoreBackend.cc: 321 ( noescape)
   318      list<string> snaps;
   319      char path[PATH_MAX];
   320      struct dirent buf, *de;
>>> Resource "dir" is not freed or pointed-to in function "readdir_r(DIR *, dirent *, dirent **)".
   321      while (::readdir_r(dir, &buf, &de) == 0) {
   322        if (!de)
   323          break;
   324    
   325        snprintf(path, sizeof(path), "%s/%s", get_basedir_path().c_str(), de->d_name);
  

/os/BtrfsFileStoreBackend.cc: 321 ( noescape)
   318      list<string> snaps;
   319      char path[PATH_MAX];
   320      struct dirent buf, *de;
>>> Resource "dir" is not freed or pointed-to in function "readdir_r(DIR *, dirent *, dirent **)".
   321      while (::readdir_r(dir, &buf, &de) == 0) {
   322        if (!de)
   323          break;
   324    
   325        snprintf(path, sizeof(path), "%s/%s", get_basedir_path().c_str(), de->d_name);
  

/os/BtrfsFileStoreBackend.cc: 345 ( leaked_storage)
   342          ret = -errno;
   343          dout(0) << "list_checkpoints: statfs '" << path << "' failed: "
   344    	      << cpp_strerror(ret) << dendl;
>>> CID 1063699: Resource leak (RESOURCE_LEAK)
>>> Variable "dir" going out of scope leaks the storage it points to.
   345          return ret;
   346        }
   347    
   348        if (fs.f_type == BTRFS_SUPER_MAGIC && basest.st_dev != st.st_dev)
   349          snaps.push_back(string(de->d_name));
  
________________________________________________________________________
CID 1063698: Improper use of negative value (NEGATIVE_RETURNS)

/tools/ceph-monstore-tool.cc: 182 ( var_tested_neg)
   179    
   180      int fd;
   181      if (vm.count("out")) {
>>> Variable "fd" tests negative.
   182        if ((fd = open(out_path.c_str(), O_WRONLY|O_CREAT|O_TRUNC, 0666)) == -1) {
   183          int _err = errno;
   184          if (_err != EISDIR) {
   185            std::cerr << "Couldn't open " << out_path << ": " << cpp_strerror(_err) << std::endl; 
   186            return 1;
  

/tools/ceph-monstore-tool.cc: 236 ( negative_returns)
   233          std::cerr << "Error getting map: " << cpp_strerror(r) << std::endl;
   234          goto done;
   235        }
>>> CID 1063698: Improper use of negative value (NEGATIVE_RETURNS)
>>> "fd" is passed to a parameter that cannot be negative.
   236        bl.write_fd(fd);
   237      } else if (cmd == "getosdmap") {
   238        if (!store_path.size()) {
   239          std::cerr << "need mon store path" << std::endl;
   240          std::cerr << desc << std::endl;
  
________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py


--557981400-202630702-1377058138=:1479--
