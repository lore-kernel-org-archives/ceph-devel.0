From: Sage Weil <sage@inktank.com>
Subject: RE: [ceph-users] Mounting Ceph on Linux/Windows
Date: Fri, 6 Dec 2013 08:06:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312060803090.19900@cobra.newdream.net>
References: <CADXLLPi+5vxfAZSPeUvrnA3SmqNs5Atia_-tO=R7x2vdxMV9vg@mail.gmail.com> <6035A0D088A63A46850C3988ED045A4B66BF5348@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1312051527390.21812@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B66BF5851@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1312051553300.21812@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B66BF6DF4@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34948 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab3LFQGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Dec 2013 11:06:25 -0500
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B66BF6DF4@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: ceph-devel@vger.kernel.org, Knut Moe <kmoe66@gmail.com>

On Fri, 6 Dec 2013, James Harper wrote:
> > 
> > > For win32 my current scheme is to just throw out all the configure and
> > > automake stuff and have a static makefile, so the build procedure is 'cd
> > > win32; make'. Do you think that's acceptable?
> > 
> > I think that's a fine, certainly as a place to start.  (I'm not sure there
> > is going to be a better solution that doesn't rely on mingw32 or cygwin or
> > something.)
> > 
> > > I suppose the configure
> > > could be modified to work with a mingw32 cross compile under Linux, but
> > > it might be a bit of a stretch to make it work in mingw32 environment
> > > under Windows (or maybe it's easy... I've never used mingw32 under
> > > Windows). At this time the configure and Makefile stuff would need to be
> > > able to build only selective bits as a lot of stuff doesn't currently
> > > build under Windows, and some may never build... osd under windows
> > would
> > > be a pretty big project for something with very limited appeal (imho)
> > 
> > Yep!
> > 
> 
> The patch is tacked onto the end of this email (unless it makes the 
> email too big for this list...)
> 
> I emailed previously about some of the changes I'd had to make (eg 
> LOCK_EXCLUSIVE is already defined for something else under Window).
> 
> What approach should I take to get this into wip-port? Some of the 
> changes are pretty light and could probably go straight in, others stomp 
> on things all over the place with messy #ifdefs, and some probably break 
> the non-win32 build altogether (will test this soon).

A github pull request is the simplest; just make the target branch 
wip-port.

> Hopefully the windows driver to allow mounting of a userspace-backed 
> device (eg librbd) won't be too hard.

Yeah!  The last conversation I had about this suggested there are a few 
userland options for block devices.  Something like "Userspace driver 
framework". (Not so for file systems, unfortunately--at least not 
upstream.)

> James 
> 
> diff --git a/src/cls/lock/cls_lock.cc b/src/cls/lock/cls_lock.cc
> index 5e0dbc3..91b00f7 100644
> --- a/src/cls/lock/cls_lock.cc
> +++ b/src/cls/lock/cls_lock.cc
> @@ -161,12 +161,12 @@ static int lock_obj(cls_method_context_t hctx,
>                      const string& cookie,
>                      const string& tag)
>  {
> -  bool exclusive = lock_type == LOCK_EXCLUSIVE;
> +  bool exclusive = lock_type == xLOCK_EXCLUSIVE;

Let's use a prefix like RADOS_ here instead of x.  Hopefully it's private 
to this module and not part of the public interface?

>    lock_info_t linfo;
>    bool fail_if_exists = (flags & LOCK_FLAG_RENEW) == 0;
>  
>    CLS_LOG(20, "requested lock_type=%s fail_if_exists=%d", cls_lock_type_str(lock_type), fail_if_exists);
> -  if (lock_type != LOCK_EXCLUSIVE &&
> +  if (lock_type != xLOCK_EXCLUSIVE &&
>        lock_type != LOCK_SHARED)
>      return -EINVAL;
>  
> diff --git a/src/cls/lock/cls_lock_client.cc b/src/cls/lock/cls_lock_client.cc
> index 54af41c..17cb3b0 100644
> --- a/src/cls/lock/cls_lock_client.cc
> +++ b/src/cls/lock/cls_lock_client.cc
> @@ -24,6 +24,8 @@ using namespace librados;
>  #include <stdlib.h>
>  #include <time.h>
>  
> +#include "include/compat.h"
> +
>  #include "cls/lock/cls_lock_types.h"
>  #include "cls/lock/cls_lock_ops.h"
>  #include "cls/lock/cls_lock_client.h"
> @@ -189,13 +191,13 @@ namespace rados {
>  
>        void Lock::lock_exclusive(ObjectWriteOperation *op)
>        {
> -        lock(op, name, LOCK_EXCLUSIVE,
> +        lock(op, name, xLOCK_EXCLUSIVE,
>               cookie, tag, description, duration, flags);
>        }
>  
>        int Lock::lock_exclusive(IoCtx *ioctx, const string& oid)
>        {
> -        return lock(ioctx, oid, name, LOCK_EXCLUSIVE,
> +        return lock(ioctx, oid, name, xLOCK_EXCLUSIVE,
>                      cookie, tag, description, duration, flags);
>        }
>  
> diff --git a/src/cls/lock/cls_lock_types.h b/src/cls/lock/cls_lock_types.h
> index aa60ed1..7d39b7b 100644
> --- a/src/cls/lock/cls_lock_types.h
> +++ b/src/cls/lock/cls_lock_types.h
> @@ -11,7 +11,7 @@
>  
>  enum ClsLockType {
>    LOCK_NONE      = 0,
> -  LOCK_EXCLUSIVE = 1,
> +  xLOCK_EXCLUSIVE = 1,
>    LOCK_SHARED    = 2,
>  };
>  
> @@ -20,7 +20,7 @@ static inline const char *cls_lock_type_str(ClsLockType type)
>      switch (type) {
>        case LOCK_NONE:
>  	return "none";
> -      case LOCK_EXCLUSIVE:
> +      case xLOCK_EXCLUSIVE:
>  	return "exclusive";
>        case LOCK_SHARED:
>  	return "shared";
> diff --git a/src/cls/log/cls_log_client.cc b/src/cls/log/cls_log_client.cc
> index f9d9bd3..a9b9410 100644
> --- a/src/cls/log/cls_log_client.cc
> +++ b/src/cls/log/cls_log_client.cc
> @@ -1,5 +1,5 @@
>  #include <errno.h>
> -
> +#include "include/compat.h"
>  #include "include/types.h"
>  #include "cls/log/cls_log_ops.h"
>  #include "include/rados/librados.hpp"
> diff --git a/src/cls/rbd/cls_rbd_client.cc b/src/cls/rbd/cls_rbd_client.cc
> index ab42591..78acb03 100644
> --- a/src/cls/rbd/cls_rbd_client.cc
> +++ b/src/cls/rbd/cls_rbd_client.cc
> @@ -9,6 +9,7 @@
>  #include "cls_rbd_client.h"
>  
>  #include <errno.h>
> +#include "include/compat.h"
>  
>  namespace librbd {
>    namespace cls_client {
> @@ -109,7 +110,7 @@ namespace librbd {
>  	if (r < 0 && ((r != -EOPNOTSUPP) && (r != -EIO)))
>  	  return r;
>  
> -	*exclusive_lock = (lock_type == LOCK_EXCLUSIVE);
> +	*exclusive_lock = (lock_type == xLOCK_EXCLUSIVE);
>        } catch (const buffer::error &err) {
>  	return -EBADMSG;
>        }
> diff --git a/src/cls/rgw/cls_rgw_client.cc b/src/cls/rgw/cls_rgw_client.cc
> index dabad29..ccda004 100644
> --- a/src/cls/rgw/cls_rgw_client.cc
> +++ b/src/cls/rgw/cls_rgw_client.cc
> @@ -1,5 +1,5 @@
>  #include <errno.h>
> -
> +#include "include/compat.h"
>  #include "include/types.h"
>  #include "cls/rgw/cls_rgw_ops.h"
>  #include "cls/rgw/cls_rgw_client.h"
> diff --git a/src/common/BackTrace.h b/src/common/BackTrace.h
> index b5d1e1d..f41a8a6 100644
> --- a/src/common/BackTrace.h
> +++ b/src/common/BackTrace.h
> @@ -2,7 +2,7 @@
>  #define CEPH_BACKTRACE_H
>  
>  #include <iosfwd>
> -#include <execinfo.h>
> +//#include <execinfo.h>
>  #include <stdlib.h>
>  
>  namespace ceph {
> @@ -15,6 +15,16 @@ struct BackTrace {
>    size_t size;
>    char **strings;
>  
> +#if defined(_WIN32)
> +  BackTrace(int s) : skip(s) {
> +    size = 0;
> +    strings = new char *[1];
> +    strings[0] = NULL;
> +  }
> +  ~BackTrace() {
> +    free(strings);
> +  }
> +#else
>    BackTrace(int s) : skip(s) {
>      size = backtrace(array, max);
>      strings = backtrace_symbols(array, size);
> @@ -22,6 +32,7 @@ struct BackTrace {
>    ~BackTrace() {
>      free(strings);
>    }
> +#endif
>  
>    BackTrace(const BackTrace& other);
>    const BackTrace& operator=(const BackTrace& other);
> diff --git a/src/common/ConfUtils.cc b/src/common/ConfUtils.cc
> index 5efde8d..d1d9efc 100644
> --- a/src/common/ConfUtils.cc
> +++ b/src/common/ConfUtils.cc
> @@ -96,6 +96,7 @@ parse_file(const std::string &fname, std::deque<std::string> *errors,
>    clear();
>  
>    int ret = 0;
> +  int i;
>    size_t sz;
>    char *buf = NULL;
>    FILE *fp = fopen(fname.c_str(), "r");
> @@ -147,6 +148,16 @@ parse_file(const std::string &fname, std::deque<std::string> *errors,
>        goto done;
>      }
>    }
> +  /* just strip out all dos newlines */
> +  i = 0;
> +  while (i < sz) {
> +    if (buf[i] == '\r') {
> +      memmove(buf + i, buf + i + 1, sz - i - 1);
> +      sz--;
> +    } else {
> +      i++;
> +    }
> +  }
>  
>    load_from_buffer(buf, sz, errors, warnings);
>    ret = 0;
> diff --git a/src/common/HeartbeatMap.cc b/src/common/HeartbeatMap.cc
> index 9787f73..951d09d 100644
> --- a/src/common/HeartbeatMap.cc
> +++ b/src/common/HeartbeatMap.cc
> @@ -17,6 +17,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#include <utime.h>
>  
>  #include "HeartbeatMap.h"
>  #include "ceph_context.h"
> @@ -143,7 +144,11 @@ void HeartbeatMap::check_touch_file()
>      if (path.length()) {
>        int fd = ::open(path.c_str(), O_WRONLY|O_CREAT, 0644);
>        if (fd >= 0) {
> +#if !defined(_WIN32)
>  	::utimes(path.c_str(), NULL);
> +#else
> +	::utime(path.c_str(), NULL);
> +#endif
>  	::close(fd);
>        } else {
>  	ldout(m_cct, 0) << "unable to touch " << path << ": "
> diff --git a/src/common/LogClient.cc b/src/common/LogClient.cc
> index 1e290b1..7c966bd 100644
> --- a/src/common/LogClient.cc
> +++ b/src/common/LogClient.cc
> @@ -26,7 +26,9 @@
>  #include <iostream>
>  #include <errno.h>
>  #include <sys/stat.h>
> -#include <syslog.h>
> +#if !defined(_WIN32)
> + #include <syslog.h>
> +#endif
>  
>  #ifdef DARWIN
>  #include <sys/param.h>
> @@ -84,11 +86,13 @@ void LogClient::do_log(clog_type type, const std::string& s)
>    e.type = type;
>    e.msg = s;
>  
> +#if !defined(_WIN32)
>    // log to syslog?
>    if (cct->_conf->clog_to_syslog) {
>      e.log_to_syslog(cct->_conf->clog_to_syslog_level,
>  		    cct->_conf->clog_to_syslog_facility);
>    }
> +#endif
>  
>    // log to monitor?
>    if (cct->_conf->clog_to_monitors) {
> diff --git a/src/common/LogEntry.cc b/src/common/LogEntry.cc
> index 97b173f..4c04ed5 100644
> --- a/src/common/LogEntry.cc
> +++ b/src/common/LogEntry.cc
> @@ -1,5 +1,7 @@
>  
> +#if !defined(_WIN32)
>  #include <syslog.h>
> +#endif
>  
>  #include <boost/algorithm/string.hpp>
>  
> @@ -42,6 +44,7 @@ void LogEntryKey::generate_test_instances(list<LogEntryKey*>& o)
>  
>  // ----
>  
> +#if !defined(_WIN32)
>  int clog_type_to_syslog_level(clog_type t)
>  {
>    switch (t) {
> @@ -139,7 +142,7 @@ void LogEntry::log_to_syslog(string level, string facility)
>      syslog(l | f, "%s", stringify(*this).c_str());
>    }
>  }
> -
> +#endif
>  void LogEntry::encode(bufferlist& bl) const
>  {
>    ENCODE_START(2, 2, bl);
> diff --git a/src/common/OutputDataSocket.cc b/src/common/OutputDataSocket.cc
> index 3051ca0..8824dfd 100644
> --- a/src/common/OutputDataSocket.cc
> +++ b/src/common/OutputDataSocket.cc
> @@ -28,15 +28,19 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <map>
> -#include <poll.h>
>  #include <set>
>  #include <sstream>
>  #include <stdint.h>
>  #include <string.h>
>  #include <string>
> -#include <sys/socket.h>
> +#if defined(_WIN32)
> + #include <winsock2.h>
> +#else
> + #include <poll.h>
> + #include <sys/socket.h>
> + #include <sys/un.h>
> +#endif
>  #include <sys/types.h>
> -#include <sys/un.h>
>  #include <unistd.h>
>  
>  #include "include/compat.h"
> @@ -101,6 +105,7 @@ static void add_cleanup_file(const char *file)
>  }
>  
>  
> +#if !defined(_WIN32)
>  OutputDataSocket::OutputDataSocket(CephContext *cct, uint64_t _backlog)
>    : m_cct(cct),
>      data_max_backlog(_backlog),
> @@ -112,6 +117,17 @@ OutputDataSocket::OutputDataSocket(CephContext *cct, uint64_t _backlog)
>      m_lock("OutputDataSocket::m_lock")
>  {
>  }
> +#else
> +OutputDataSocket::OutputDataSocket(CephContext *cct, uint64_t _backlog)
> +  : m_cct(cct),
> +    data_max_backlog(_backlog),
> +    m_sock_handle(INVALID_HANDLE_VALUE),
> +    going_down(false),
> +    data_size(0),
> +    m_lock("OutputDataSocket::m_lock")
> +{
> +}
> +#endif
>  
>  OutputDataSocket::~OutputDataSocket()
>  {
> @@ -131,6 +147,7 @@ OutputDataSocket::~OutputDataSocket()
>  #define PFL_SUCCESS ((void*)(intptr_t)0)
>  #define PFL_FAIL ((void*)(intptr_t)1)
>  
> +#if !defined(_WIN32)
>  std::string OutputDataSocket::create_shutdown_pipe(int *pipe_rd, int *pipe_wr)
>  {
>    int pipefd[2];
> @@ -145,7 +162,9 @@ std::string OutputDataSocket::create_shutdown_pipe(int *pipe_rd, int *pipe_wr)
>    *pipe_wr = pipefd[1];
>    return "";
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  std::string OutputDataSocket::bind_and_listen(const std::string &sock_path, int *fd)
>  {
>    ldout(m_cct, 5) << "bind_and_listen " << sock_path << dendl;
> @@ -215,7 +234,9 @@ std::string OutputDataSocket::bind_and_listen(const std::string &sock_path, int
>    *fd = sock_fd;
>    return "";
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  void* OutputDataSocket::entry()
>  {
>    ldout(m_cct, 5) << "entry start" << dendl;
> @@ -248,11 +269,28 @@ void* OutputDataSocket::entry()
>      }
>    }
>    ldout(m_cct, 5) << "entry exit" << dendl;
> +  return PFL_SUCCESS; // unreachable
> +}
> +#else
> +void* OutputDataSocket::entry()
> +{
> +  ldout(m_cct, 5) << "entry start" << dendl;
> +  while (true) {
> +    DWORD ret = WaitForSingleObject(m_sock_handle, INFINITE);
> +    if (ret != WAIT_OBJECT_0) {
> +      lderr(m_cct) << "OutputDataSocket: WaitForSingleObject error: " << dendl;
> +      return PFL_FAIL;
> +    }
>  
> +    do_accept();
> +  }
> +  ldout(m_cct, 5) << "entry exit" << dendl;
>    return PFL_SUCCESS; // unreachable
>  }
> +#endif
>  
>  
> +#if !defined(_WIN32)
>  bool OutputDataSocket::do_accept()
>  {
>    struct sockaddr_un address;
> @@ -270,10 +308,32 @@ bool OutputDataSocket::do_accept()
>  
>    handle_connection(connection_fd);
>    close_connection(connection_fd);
> +  return 0;
> +}
> +#else
> +bool OutputDataSocket::do_accept()
> +{
> +  CreateNamedPipeW
> +  struct sockaddr_un address;
> +  socklen_t address_length = sizeof(address);
> +  ldout(m_cct, 30) << "OutputDataSocket: calling accept" << dendl;
> +  int connection_fd = accept(m_sock_fd, (struct sockaddr*) &address,
> +			     &address_length);
> +  ldout(m_cct, 30) << "OutputDataSocket: finished accept" << dendl;
> +  if (connection_fd < 0) {
> +    int err = errno;
> +    lderr(m_cct) << "OutputDataSocket: do_accept error: '"
> +			   << cpp_strerror(err) << dendl;
> +    return false;
> +  }
>  
> +  handle_connection(connection_fd);
> +  close_connection(connection_fd);
>    return 0;
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  void OutputDataSocket::handle_connection(int fd)
>  {
>    bufferlist bl;
> @@ -311,7 +371,48 @@ void OutputDataSocket::handle_connection(int fd)
>      ret = dump_data(fd);
>    } while (ret >= 0);
>  }
> +#else
> +void OutputDataSocket::handle_connection(HANDLE handle)
> +{
> +  bufferlist bl;
> +
> +  m_lock.Lock();
> +  init_connection(bl);
> +  m_lock.Unlock();
>  
> +  if (bl.length()) {
> +    /* need to special case the connection init buffer output, as it needs
> +     * to be dumped before any data, including older data that was sent
> +     * before the connection was established, or before we identified
> +     * older connection was broken
> +     */
> +    DWORD bytes_written;
> +    BOOL ret = WriteFile(handle, bl.c_str(), bl.length(), &bytes_written, NULL);
> +    if (!ret) {
> +      return;
> +    }
> +  }
> +
> +  int ret = dump_data(handle);
> +  if (ret < 0)
> +    return;
> +
> +  do {
> +    m_lock.Lock();
> +    cond.Wait(m_lock);
> +
> +    if (going_down) {
> +      m_lock.Unlock();
> +      break;
> +    }
> +    m_lock.Unlock();
> +
> +    ret = dump_data(handle);
> +  } while (ret >= 0);
> +}
> +#endif
> +
> +#if !defined(_WIN32)
>  int OutputDataSocket::dump_data(int fd)
>  {
>    m_lock.Lock(); 
> @@ -339,12 +440,50 @@ int OutputDataSocket::dump_data(int fd)
>  
>    return 0;
>  }
> +#else
> +int OutputDataSocket::dump_data(HANDLE handle)
> +{
> +  m_lock.Lock(); 
> +  list<bufferlist> l;
> +  l = data;
> +  data.clear();
> +  data_size = 0;
> +  m_lock.Unlock();
>  
> +  for (list<bufferlist>::iterator iter = l.begin(); iter != l.end(); ++iter) {
> +    bufferlist& bl = *iter;
> +    DWORD bytes_written;
> +    BOOL ret = WriteFile(handle, bl.c_str(), bl.length(), &bytes_written, NULL);
> +    if (ret) {
> +      BOOL ret = WriteFile(handle, delim.c_str(), delim.length(), &bytes_written, NULL);
> +    }
> +    if (!ret) {
> +      for (; iter != l.end(); ++iter) {
> +        bufferlist& bl = *iter;
> +	data.push_back(bl);
> +	data_size += bl.length();
> +      }
> +      return ret;
> +    }
> +  }
> +
> +  return 0;
> +}
> +#endif
> +
> +#if !defined(_WIN32)
>  void OutputDataSocket::close_connection(int fd)
>  {
>    TEMP_FAILURE_RETRY(close(fd));
>  }
> +#else
> +void OutputDataSocket::close_connection(HANDLE handle)
> +{
> +  CloseHandle(handle);
> +}
> +#endif
>  
> +#if !defined(_WIN32)
>  bool OutputDataSocket::init(const std::string &path)
>  {
>    ldout(m_cct, 5) << "init " << path << dendl;
> @@ -375,7 +514,31 @@ bool OutputDataSocket::init(const std::string &path)
>    add_cleanup_file(m_path.c_str());
>    return true;
>  }
> +#else
> +bool OutputDataSocket::init(const std::string &path)
> +{
> +  ldout(m_cct, 5) << "init " << path << dendl;
> +
> +  /* Set up things for the new thread */
> +  std::string err;
> +  HANDLE handle;
> +  err = bind_and_listen(path, &handle);
> +  if (!err.empty()) {
> +    lderr(m_cct) << "OutputDataSocketConfigObs::init: failed: " << err << dendl;
> +    return false;
> +  }
> +
> +  /* Create new thread */
> +  m_sock_handle = handle;
> +  m_path = path;
> +  create();
> +  add_cleanup_file(m_path.c_str());
> +  return true;
> +}
> +#endif
> +
>  
> +#if !defined(_WIN32)
>  void OutputDataSocket::shutdown()
>  {
>    m_lock.Lock();
> @@ -404,6 +567,22 @@ void OutputDataSocket::shutdown()
>    remove_cleanup_file(m_path.c_str());
>    m_path.clear();
>  }
> +#else
> +void OutputDataSocket::shutdown()
> +{
> +  m_lock.Lock();
> +  going_down = true;
> +  cond.Signal();
> +  m_lock.Unlock();
> +
> +  ldout(m_cct, 5) << "shutdown" << dendl;
> +
> +  join();
> +
> +  remove_cleanup_file(m_path.c_str());
> +  m_path.clear();
> +}
> +#endif
>  
>  void OutputDataSocket::append_output(bufferlist& bl)
>  {
> diff --git a/src/common/OutputDataSocket.h b/src/common/OutputDataSocket.h
> index f581a56..5d9194f 100644
> --- a/src/common/OutputDataSocket.h
> +++ b/src/common/OutputDataSocket.h
> @@ -40,23 +40,39 @@ protected:
>    virtual void init_connection(bufferlist& bl) {}
>    void shutdown();
>  
> +#if !defined(_WIN32)
>    std::string create_shutdown_pipe(int *pipe_rd, int *pipe_wr);
>    std::string bind_and_listen(const std::string &sock_path, int *fd);
> +#else
> +  std::string bind_and_listen(const std::string &sock_path, HANDLE *handle);
> +#endif
>  
>    void *entry();
>    bool do_accept();
>  
> +#if !defined(_WIN32)
>    void handle_connection(int fd);
>    void close_connection(int fd);
>  
>    int dump_data(int fd);
> +#else
> +  void handle_connection(HANDLE handle);
> +  void close_connection(HANDLE handle);
> +
> +  int dump_data(HANDLE handle);
> +#endif
>  
>    CephContext *m_cct;
>    uint64_t data_max_backlog;
>    std::string m_path;
> +
> +#if !defined(_WIN32)
>    int m_sock_fd;
>    int m_shutdown_rd_fd;
>    int m_shutdown_wr_fd;
> +#else
> +  HANDLE m_sock_handle;
> +#endif
>    bool going_down;
>  
>    uint64_t data_size;
> diff --git a/src/common/Thread.cc b/src/common/Thread.cc
> index 0f4e322..565a3d0 100644
> --- a/src/common/Thread.cc
> +++ b/src/common/Thread.cc
> @@ -83,6 +83,7 @@ int Thread::try_create(size_t stacksize)
>    // the set of signals we want to block.  (It's ok to block signals more
>    // signals than usual for a little while-- they will just be delivered to
>    // another thread or delieverd to this thread later.)
> +#if !defined(_WIN32)
>    sigset_t old_sigset;
>    if (g_code_env == CODE_ENVIRONMENT_LIBRARY) {
>      block_signals(NULL, &old_sigset);
> @@ -91,8 +92,11 @@ int Thread::try_create(size_t stacksize)
>      int to_block[] = { SIGPIPE , 0 };
>      block_signals(to_block, &old_sigset);
>    }
> +#endif
>    r = pthread_create(&thread_id, thread_attr, _entry_func, (void*)this);
> +#if !defined(_WIN32)
>    restore_sigset(&old_sigset);
> +#endif
>  
>    if (thread_attr)
>      free(thread_attr);
> diff --git a/src/common/addr_parsing.c b/src/common/addr_parsing.c
> index c01f817..bc1702c 100644
> --- a/src/common/addr_parsing.c
> +++ b/src/common/addr_parsing.c
> @@ -20,7 +20,13 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #endif
> +#if !defined(_WIN32)
>  #include <netdb.h>
> +#else
> +#include <winsock2.h>
> +#include <ws2tcpip.h>
> +#endif
> +#include "include/compat.h"
>  
>  #define BUF_SIZE 128
>  
> diff --git a/src/common/admin_socket.cc b/src/common/admin_socket.cc
> index 12e5868..fa7a069 100644
> --- a/src/common/admin_socket.cc
> +++ b/src/common/admin_socket.cc
> @@ -29,15 +29,15 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <map>
> -#include <poll.h>
> +//#include <poll.h>
>  #include <set>
>  #include <sstream>
>  #include <stdint.h>
>  #include <string.h>
>  #include <string>
> -#include <sys/socket.h>
> +//#include <sys/socket.h>
>  #include <sys/types.h>
> -#include <sys/un.h>
> +//#include <sys/un.h>
>  #include <unistd.h>
>  
>  #include "include/compat.h"
> @@ -147,10 +147,10 @@ std::string AdminSocket::create_shutdown_pipe(int *pipe_rd, int *pipe_wr)
>    return "";
>  }
>  
> +#if !defined(_WIN32)
>  std::string AdminSocket::bind_and_listen(const std::string &sock_path, int *fd)
>  {
>    ldout(m_cct, 5) << "bind_and_listen " << sock_path << dendl;
> -
>    struct sockaddr_un address;
>    if (sock_path.size() > sizeof(address.sun_path) - 1) {
>      ostringstream oss;
> @@ -216,7 +216,9 @@ std::string AdminSocket::bind_and_listen(const std::string &sock_path, int *fd)
>    *fd = sock_fd;
>    return "";
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  void* AdminSocket::entry()
>  {
>    ldout(m_cct, 5) << "entry start" << dendl;
> @@ -250,8 +252,10 @@ void* AdminSocket::entry()
>    }
>    ldout(m_cct, 5) << "entry exit" << dendl;
>  }
> +#endif
>  
>  
> +#if !defined(_WIN32)
>  bool AdminSocket::do_accept()
>  {
>    struct sockaddr_un address;
> @@ -379,6 +383,7 @@ bool AdminSocket::do_accept()
>    TEMP_FAILURE_RETRY(close(connection_fd));
>    return rval;
>  }
> +#endif
>  
>  int AdminSocket::register_command(std::string command, std::string cmddesc, AdminSocketHook *hook, std::string help)
>  {
> diff --git a/src/common/admin_socket_client.cc b/src/common/admin_socket_client.cc
> index 335695f..908a2f5 100644
> --- a/src/common/admin_socket_client.cc
> +++ b/src/common/admin_socket_client.cc
> @@ -20,26 +20,35 @@
>  #include "common/safe_io.h"
>  #include "common/admin_socket_client.h"
>  
> +#if !defined(_WIN32)
>  #include <arpa/inet.h>
> +#endif
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <map>
> +#if !defined(_WIN32)
>  #include <poll.h>
> +#endif
>  #include <sstream>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <string>
> +#if !defined(_WIN32)
>  #include <sys/socket.h>
> +#endif
>  #include <sys/types.h>
> +#if !defined(_WIN32)
>  #include <sys/un.h>
> +#endif
>  #include <time.h>
>  #include <unistd.h>
>  #include <vector>
>  
>  using std::ostringstream;
>  
> +#if !defined(_WIN32)
>  const char* get_rand_socket_path()
>  {
>    static char *g_socket_path = NULL;
> @@ -57,7 +66,9 @@ const char* get_rand_socket_path()
>    }
>    return g_socket_path;
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  static std::string asok_connect(const std::string &path, int *fd)
>  {
>    int socket_fd = socket(PF_UNIX, SOCK_STREAM, 0);
> @@ -107,6 +118,7 @@ static std::string asok_connect(const std::string &path, int *fd)
>    *fd = socket_fd;
>    return "";
>  }
> +#endif
>  
>  static std::string asok_request(int socket_fd, std::string request)
>  {
> @@ -127,6 +139,7 @@ AdminSocketClient(const std::string &path)
>  {
>  }
>  
> +#if !defined(_WIN32)
>  std::string AdminSocketClient::do_request(std::string request, std::string *result)
>  {
>    int socket_fd = 0, res;
> @@ -168,3 +181,4 @@ done:
>   out:
>    return err;
>  }
> +#endif
> diff --git a/src/common/armor.c b/src/common/armor.c
> index 706e01e..a860552 100644
> --- a/src/common/armor.c
> +++ b/src/common/armor.c
> @@ -2,7 +2,7 @@
>  #if defined(__linux__)
>  #include <linux/errno.h>
>  #else
> -#include <sys/errno.h>
> +#include <errno.h>
>  #endif
>  
>  /*
> diff --git a/src/common/blkdev.cc b/src/common/blkdev.cc
> index 9c7240c..49028bc 100644
> --- a/src/common/blkdev.cc
> +++ b/src/common/blkdev.cc
> @@ -51,6 +51,10 @@ int get_block_device_size(int fd, int64_t *psize)
>    return ret;
>  }
>  
> +#elif defined(_WIN32)
> +
> +/* win32 currently doesn't use this */
> +
>  #else
>  # error "Unable to query block device size: unsupported platform, please report."
>  #endif
> diff --git a/src/common/buffer.cc b/src/common/buffer.cc
> index 95c7acd..fd303b3 100644
> --- a/src/common/buffer.cc
> +++ b/src/common/buffer.cc
> @@ -26,7 +26,7 @@
>  #include <errno.h>
>  #include <fstream>
>  #include <sstream>
> -#include <sys/uio.h>
> +//#include <sys/uio.h>
>  #include <limits.h>
>  
>  namespace ceph {
> @@ -101,7 +101,7 @@ static uint32_t simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZE
>      }
>  
>      bool is_page_aligned() {
> -      return ((long)data & ~CEPH_PAGE_MASK) == 0;
> +      return ((long)(intptr_t)data & ~CEPH_PAGE_MASK) == 0;
>      }
>      bool is_n_page_sized() {
>        return (len & ~CEPH_PAGE_MASK) == 0;
> @@ -154,7 +154,7 @@ static uint32_t simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZE
>      }
>    };
>  
> -#ifndef __CYGWIN__
> +#if !defined(__CYGWIN__) && !defined(_WIN32)
>    class buffer::raw_mmap_pages : public buffer::raw {
>    public:
>      raw_mmap_pages(unsigned l) : raw(l) {
> @@ -201,13 +201,13 @@ static uint32_t simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZE
>    };
>  #endif
>  
> -#ifdef __CYGWIN__
> +#if defined(__CYGWIN__) || defined(_WIN32)
>    class buffer::raw_hack_aligned : public buffer::raw {
>      char *realdata;
>    public:
>      raw_hack_aligned(unsigned l) : raw(l) {
>        realdata = new char[len+CEPH_PAGE_SIZE-1];
> -      unsigned off = ((unsigned)realdata) & ~CEPH_PAGE_MASK;
> +      unsigned off = ((unsigned)(intptr_t)realdata) & ~CEPH_PAGE_MASK;
>        if (off)
>  	data = realdata + CEPH_PAGE_SIZE - off;
>        else
> @@ -216,7 +216,7 @@ static uint32_t simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZE
>        //cout << "hack aligned " << (unsigned)data
>        //<< " in raw " << (unsigned)realdata
>        //<< " off " << off << std::endl;
> -      assert(((unsigned)data & (CEPH_PAGE_SIZE-1)) == 0);
> +      assert(((unsigned)(intptr_t)data & (CEPH_PAGE_SIZE-1)) == 0);
>      }
>      ~raw_hack_aligned() {
>        delete[] realdata;
> @@ -285,7 +285,7 @@ static uint32_t simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZE
>      return new raw_static(buf, len);
>    }
>    buffer::raw* buffer::create_page_aligned(unsigned len) {
> -#ifndef __CYGWIN__
> +#if !defined(__CYGWIN__) && !defined(_WIN32)
>      //return new raw_mmap_pages(len);
>      return new raw_posix_aligned(len);
>  #else
> @@ -1269,6 +1269,30 @@ int buffer::list::write_file(const char *fn, int mode)
>    return 0;
>  }
>  
> +struct iovec {
> +  void *iov_base;
> +  size_t iov_len;
> +};
> +
> +#define IOV_MAX 16
> +
> +static ssize_t writev(int fd, const struct iovec *iov, int iovcnt) {
> +  int count;
> +  int len;
> +  int ret;
> +
> +  for (count = 0; count < iovcnt; count++) {
> +    ret = write(fd, iov[count].iov_base, iov[count].iov_len);
> +    if (ret == -1) {
> +      return ret;
> +    } else if (ret == 0) {
> +      return len;
> +    }
> +    len += ret;
> +  }
> +  return len;
> +}

I wonder if we should make a compat/ directory and put stuff like this in 
there.

sage

> +  
>  int buffer::list::write_fd(int fd) const
>  {
>    // use writev!
> diff --git a/src/common/ceph_context.cc b/src/common/ceph_context.cc
> index e22afeb..96326ea 100644
> --- a/src/common/ceph_context.cc
> +++ b/src/common/ceph_context.cc
> @@ -255,7 +255,9 @@ CephContext::CephContext(uint32_t module_type_)
>      _module_type(module_type_),
>      _service_thread(NULL),
>      _log_obs(NULL),
> +#if !defined(_WIN32)
>      _admin_socket(NULL),
> +#endif
>      _perf_counters_collection(NULL),
>      _perf_counters_conf_obs(NULL),
>      _heartbeat_map(NULL),
> @@ -271,10 +273,13 @@ CephContext::CephContext(uint32_t module_type_)
>    _conf->add_observer(_log_obs);
>  
>    _perf_counters_collection = new PerfCountersCollection(this);
> +#if !defined(_WIN32)
>    _admin_socket = new AdminSocket(this);
> +#endif
>    _heartbeat_map = new HeartbeatMap(this);
>  
>    _admin_hook = new CephContextHook(this);
> +#if !defined(_WIN32)
>    _admin_socket->register_command("perfcounters_dump", "perfcounters_dump", _admin_hook, "");
>    _admin_socket->register_command("1", "1", _admin_hook, "");
>    _admin_socket->register_command("perf dump", "perf dump", _admin_hook, "dump perfcounters value");
> @@ -287,6 +292,7 @@ CephContext::CephContext(uint32_t module_type_)
>    _admin_socket->register_command("log flush", "log flush", _admin_hook, "flush log entries to log file");
>    _admin_socket->register_command("log dump", "log dump", _admin_hook, "dump recent log entries to log file");
>    _admin_socket->register_command("log reopen", "log reopen", _admin_hook, "reopen log file");
> +#endif
>  
>    _crypto_none = new CryptoNone;
>    _crypto_aes = new CryptoAES;
> @@ -300,6 +306,7 @@ CephContext::~CephContext()
>  
>    join_service_thread();
>  
> +#if !defined(_WIN32)
>    _admin_socket->unregister_command("perfcounters_dump");
>    _admin_socket->unregister_command("perf dump");
>    _admin_socket->unregister_command("1");
> @@ -312,8 +319,11 @@ CephContext::~CephContext()
>    _admin_socket->unregister_command("log flush");
>    _admin_socket->unregister_command("log dump");
>    _admin_socket->unregister_command("log reopen");
> +#endif
>    delete _admin_hook;
> +#if !defined(_WIN32)
>    delete _admin_socket;
> +#endif
>  
>    delete _heartbeat_map;
>  
> @@ -349,18 +359,22 @@ void CephContext::start_service_thread()
>    _service_thread->create();
>    ceph_spin_unlock(&_service_thread_lock);
>  
> +#if !defined(_WIN32)
>    // make logs flush on_exit()
>    if (_conf->log_flush_on_exit)
>      _log->set_flush_on_exit();
> +#endif
>  
>    // Trigger callbacks on any config observers that were waiting for
>    // it to become safe to start threads.
>    _conf->set_val("internal_safe_to_start_threads", "true");
>    _conf->call_all_observers();
>  
> +#if !defined(_WIN32)
>    // start admin socket
>    if (_conf->admin_socket.length())
>      _admin_socket->init(_conf->admin_socket);
> +#endif
>  }
>  
>  void CephContext::reopen_logs()
> diff --git a/src/common/ceph_context.h b/src/common/ceph_context.h
> index ba60620..ec3e7c0 100644
> --- a/src/common/ceph_context.h
> +++ b/src/common/ceph_context.h
> @@ -23,6 +23,8 @@
>  #include "common/cmdparse.h"
>  #include "include/Spinlock.h"
>  
> +#include <pthread.h>
> +
>  class AdminSocket;
>  class CephContextServiceThread;
>  class PerfCountersCollection;
> diff --git a/src/common/ceph_json.cc b/src/common/ceph_json.cc
> index a48e063..87da15b 100644
> --- a/src/common/ceph_json.cc
> +++ b/src/common/ceph_json.cc
> @@ -438,6 +438,7 @@ void decode_json_obj(bufferlist& val, JSONObj *obj)
>    }
>  }
>  
> +#if !defined(_WIN32)
>  void decode_json_obj(utime_t& val, JSONObj *obj)
>  {
>    string s = obj->get_data();
> @@ -450,6 +451,7 @@ void decode_json_obj(utime_t& val, JSONObj *obj)
>      throw JSONDecoder::err("failed to decode utime_t");
>    }
>  }
> +#endif
>  
>  void encode_json(const char *name, const string& val, Formatter *f)
>  {
> diff --git a/src/common/errno.cc b/src/common/errno.cc
> index a981ab7..baee418 100644
> --- a/src/common/errno.cc
> +++ b/src/common/errno.cc
> @@ -4,6 +4,8 @@
>  #include <string>
>  #include <string.h>
>  
> +#include "include/compat.h"
> +
>  std::string cpp_strerror(int err)
>  {
>    char buf[128];
> diff --git a/src/common/fd.cc b/src/common/fd.cc
> index 547e0f8..a57eba5 100644
> --- a/src/common/fd.cc
> +++ b/src/common/fd.cc
> @@ -24,6 +24,7 @@
>  
>  void dump_open_fds(CephContext *cct)
>  {
> +#if !defined(_WIN32)
>    const char *fn = "/proc/self/fd";
>    DIR *d = opendir(fn);
>    if (!d) {
> @@ -54,4 +55,7 @@ void dump_open_fds(CephContext *cct)
>    lderr(cct) << "dump_open_fds dumped " << n << " open files" << dendl;
>  
>    closedir(d);
> +#else
> +  lderr(cct) << "dump_open_fds not supported under Windows" << dendl;
> +#endif
>  }
> diff --git a/src/common/ipaddr.cc b/src/common/ipaddr.cc
> index f38f0cd..3fcac6b 100644
> --- a/src/common/ipaddr.cc
> +++ b/src/common/ipaddr.cc
> @@ -1,9 +1,16 @@
>  #include "include/ipaddr.h"
>  
> -#include <arpa/inet.h>
> +#if !defined(_WIN32)
> + #include <arpa/inet.h>
> +#else
> + #include <stdint.h>
> + #include <winsock2.h>
> + #include <ws2tcpip.h>
> +#endif
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/socket.h>
> +#include "include/compat.h"
>  
>  #include "acconfig.h"
>  
> @@ -31,7 +38,7 @@ static void netmask_ipv4(const struct in_addr *addr,
>    out->s_addr = addr->s_addr & mask;
>  }
>  
> -
> +#if !defined(_WIN32)
>  const struct sockaddr *find_ipv4_in_subnet(const struct ifaddrs *addrs,
>  					   const struct sockaddr_in *net,
>  					   unsigned int prefix_len) {
> @@ -57,7 +64,7 @@ const struct sockaddr *find_ipv4_in_subnet(const struct ifaddrs *addrs,
>  
>    return NULL;
>  }
> -
> +#endif
>  
>  static void netmask_ipv6(const struct in6_addr *addr,
>  			 unsigned int prefix_len,
> @@ -72,7 +79,7 @@ static void netmask_ipv6(const struct in6_addr *addr,
>      memset(out->s6_addr+prefix_len/8+1, 0, 16-prefix_len/8-1);
>  }
>  
> -
> +#if !defined(_WIN32)
>  const struct sockaddr *find_ipv6_in_subnet(const struct ifaddrs *addrs,
>  					   const struct sockaddr_in6 *net,
>  					   unsigned int prefix_len) {
> @@ -97,8 +104,9 @@ const struct sockaddr *find_ipv6_in_subnet(const struct ifaddrs *addrs,
>  
>    return NULL;
>  }
> +#endif
>  
> -
> +#if !defined(_WIN32)
>  const struct sockaddr *find_ip_in_subnet(const struct ifaddrs *addrs,
>  					 const struct sockaddr *net,
>  					 unsigned int prefix_len) {
> @@ -112,8 +120,9 @@ const struct sockaddr *find_ip_in_subnet(const struct ifaddrs *addrs,
>  
>    return NULL;
>  }
> +#endif
>  
> -
> +#if !defined(_WIN32)
>  bool parse_network(const char *s, struct sockaddr *network, unsigned int *prefix_len) {
>    char *slash = strchr((char*)s, '/');
>    if (!slash) {
> @@ -161,3 +170,4 @@ bool parse_network(const char *s, struct sockaddr *network, unsigned int *prefix
>  
>    return false;
>  }
> +#endif
> diff --git a/src/common/page.cc b/src/common/page.cc
> index 6ba4215..5425742 100644
> --- a/src/common/page.cc
> +++ b/src/common/page.cc
> @@ -12,7 +12,11 @@ namespace ceph {
>      return n;
>    }
>  
> +#if !defined(_WIN32)
>    unsigned _page_size = sysconf(_SC_PAGESIZE);
> +#else
> +  unsigned _page_size = 4096;
> +#endif
>    unsigned long _page_mask = ~(unsigned long)(_page_size - 1);
>    unsigned _page_shift = _get_bits_of(_page_size);
>  
> diff --git a/src/common/perf_counters.cc b/src/common/perf_counters.cc
> index 4fe1354..f2d5e4d 100644
> --- a/src/common/perf_counters.cc
> +++ b/src/common/perf_counters.cc
> @@ -25,6 +25,7 @@
>  #include <stdint.h>
>  #include <string.h>
>  #include <string>
> +#include "include/compat.h"
>  
>  using std::ostringstream;
>  
> diff --git a/src/common/pick_address.cc b/src/common/pick_address.cc
> index f685362..3ed73ed 100644
> --- a/src/common/pick_address.cc
> +++ b/src/common/pick_address.cc
> @@ -14,7 +14,9 @@
>  
>  #include "common/pick_address.h"
>  
> +#if !defined(_WIN32)
>  #include <netdb.h>
> +#endif
>  #include <errno.h>
>  
>  #include "include/ipaddr.h"
> @@ -24,6 +26,7 @@
>  
>  #define dout_subsys ceph_subsys_
>  
> +#if !defined(_WIN32)
>  static const struct sockaddr *find_ip_in_subnet_list(CephContext *cct,
>  						     const struct ifaddrs *ifa,
>  						     const std::string &networks)
> @@ -47,6 +50,7 @@ static const struct sockaddr *find_ip_in_subnet_list(CephContext *cct,
>  
>    return NULL;
>  }
> +#endif
>  
>  // observe this change
>  struct Observer : public md_config_obs_t {
> @@ -65,6 +69,7 @@ struct Observer : public md_config_obs_t {
>    }
>  };
>  
> +#if !defined(_WIN32)
>  static void fill_in_one_address(CephContext *cct,
>  				const struct ifaddrs *ifa,
>  				const string networks,
> @@ -101,7 +106,9 @@ static void fill_in_one_address(CephContext *cct,
>  
>    cct->_conf->remove_observer(&obs);
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  void pick_addresses(CephContext *cct, int needs)
>  {
>    struct ifaddrs *ifa;
> @@ -126,7 +133,9 @@ void pick_addresses(CephContext *cct, int needs)
>  
>    freeifaddrs(ifa);
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  bool have_local_addr(CephContext *cct, const list<entity_addr_t>& ls, entity_addr_t *match)
>  {
>    struct ifaddrs *ifa;
> @@ -155,3 +164,4 @@ bool have_local_addr(CephContext *cct, const list<entity_addr_t>& ls, entity_add
>    freeifaddrs(ifa);
>    return found;
>  }
> +#endif
> diff --git a/src/common/pipe.c b/src/common/pipe.c
> index 8144558..b3874ce 100644
> --- a/src/common/pipe.c
> +++ b/src/common/pipe.c
> @@ -20,6 +20,7 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  
> +#if !defined(_WIN32)
>  int pipe_cloexec(int pipefd[2])
>  {
>  	int ret;
> @@ -59,3 +60,4 @@ out:
>  	return ret;
>  #endif
>  }
> +#endif
> diff --git a/src/common/run_cmd.cc b/src/common/run_cmd.cc
> index 5f5cc3c..41d7e49 100644
> --- a/src/common/run_cmd.cc
> +++ b/src/common/run_cmd.cc
> @@ -19,12 +19,13 @@
>  #include <stdarg.h>
>  #include <stdlib.h>
>  #include <sys/types.h>
> -#include <sys/wait.h>
> +//#include <sys/wait.h>
>  #include <unistd.h>
>  #include <vector>
>  
>  using std::ostringstream;
>  
> +#if !defined(_WIN32)
>  std::string run_cmd(const char *cmd, ...)
>  {
>    std::vector <const char *> arr;
> @@ -78,3 +79,4 @@ std::string run_cmd(const char *cmd, ...)
>    oss << "run_cmd(" << cmd << "): terminated by unknown mechanism";
>    return oss.str();
>  }
> +#endif
> diff --git a/src/common/secret.c b/src/common/secret.c
> index 8215093..d792ff9 100644
> --- a/src/common/secret.c
> +++ b/src/common/secret.c
> @@ -18,7 +18,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <fcntl.h>
> -#include <keyutils.h>
> +//#include <keyutils.h>
>  #include <sys/types.h>
>  
>  #include "common/armor.h"
> diff --git a/src/common/signal.cc b/src/common/signal.cc
> index 406ff46..fe74807 100644
> --- a/src/common/signal.cc
> +++ b/src/common/signal.cc
> @@ -25,6 +25,7 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  
> +#if !defined(_WIN32)
>  std::string signal_mask_to_str()
>  {
>    sigset_t old_sigset;
> @@ -44,7 +45,9 @@ std::string signal_mask_to_str()
>    oss << " }";
>    return oss.str();
>  }
> +#endif
>  
> +#if !defined(_WIN32)
>  /* Block the signals in 'siglist'. If siglist == NULL, block all signals. */
>  void block_signals(const int *siglist, sigset_t *old_sigset)
>  {
> @@ -63,6 +66,7 @@ void block_signals(const int *siglist, sigset_t *old_sigset)
>    int ret = pthread_sigmask(SIG_BLOCK, &sigset, old_sigset);
>    assert(ret == 0);
>  }
> +#endif
>  
>  void restore_sigset(const sigset_t *old_sigset)
>  {
> @@ -70,6 +74,7 @@ void restore_sigset(const sigset_t *old_sigset)
>    assert(ret == 0);
>  }
>  
> +#if !defined(_WIN32)
>  void unblock_all_signals(sigset_t *old_sigset)
>  {
>    sigset_t sigset;
> @@ -78,3 +83,4 @@ void unblock_all_signals(sigset_t *old_sigset)
>    int ret = pthread_sigmask(SIG_UNBLOCK, &sigset, old_sigset);
>    assert(ret == 0);
>  }
> +#endif
> diff --git a/src/common/xattr.c b/src/common/xattr.c
> index db1900d..b4c6a90 100644
> --- a/src/common/xattr.c
> +++ b/src/common/xattr.c
> @@ -294,3 +294,4 @@ ceph_os_fremovexattr(int fd, const char *name)
>  
>  	return (error);
>  }
> +#endif
> diff --git a/src/crush/CrushCompiler.cc b/src/crush/CrushCompiler.cc
> index 5f92bf7..2665206 100644
> --- a/src/crush/CrushCompiler.cc
> +++ b/src/crush/CrushCompiler.cc
> @@ -1,5 +1,6 @@
>  
>  #include "CrushCompiler.h"
> +#include "include/compat.h"
>  
>  #ifndef EBADE
>  #define EBADE EFTYPE
> diff --git a/src/crush/CrushTester.cc b/src/crush/CrushTester.cc
> index b38386d..adf1c76 100644
> --- a/src/crush/CrushTester.cc
> +++ b/src/crush/CrushTester.cc
> @@ -144,6 +144,8 @@ void CrushTester::adjust_weights(vector<__u32>& weight)
>      }
>    }
>  }
> +#if !defined(_WIN32)
> +#endif
>  
>  bool CrushTester::check_valid_placement(int ruleno, vector<int> in, const vector<__u32>& weight)
>  {
> @@ -236,6 +238,7 @@ bool CrushTester::check_valid_placement(int ruleno, vector<int> in, const vector
>    return valid_placement;
>  }
>  
> +#if !defined(_WIN32)
>  int CrushTester::random_placement(int ruleno, vector<int>& out, int maxout, vector<__u32>& weight)
>  {
>    // get the total weight of the system
> @@ -282,6 +285,7 @@ int CrushTester::random_placement(int ruleno, vector<int>& out, int maxout, vect
>  
>    return 0;
>  }
> +#endif
>  
>  void CrushTester::write_integer_indexed_vector_data_string(vector<string> &dst, int index, vector<int> vector_data)
>  {
> diff --git a/src/crush/CrushWrapper.cc b/src/crush/CrushWrapper.cc
> index d17166b..2338824 100644
> --- a/src/crush/CrushWrapper.cc
> +++ b/src/crush/CrushWrapper.cc
> @@ -1,4 +1,4 @@
> -
> +#include "include/compat.h"
>  #include "common/debug.h"
>  #include "common/Formatter.h"
>  
> diff --git a/src/crush/crush.h b/src/crush/crush.h
> index 4adabcb..f5e83c1 100644
> --- a/src/crush/crush.h
> +++ b/src/crush/crush.h
> @@ -5,7 +5,7 @@
>  
>  #if defined(__linux__)
>  #include <linux/types.h>
> -#elif defined(__FreeBSD__)
> +#elif defined(__FreeBSD__) || defined(_WIN32)
>  #include <sys/types.h>
>  #endif
>  
> diff --git a/src/crush/hash.c b/src/crush/hash.c
> index 8f1d31a..6d0035f 100644
> --- a/src/crush/hash.c
> +++ b/src/crush/hash.c
> @@ -4,7 +4,7 @@
>  
>  #if defined(__linux__)
>  #include <linux/types.h>
> -#elif defined(__FreeBSD__)
> +#elif defined(__FreeBSD__) || defined(_WIN32)
>  #include <sys/types.h>
>  #endif
>  
> diff --git a/src/global/global_init.cc b/src/global/global_init.cc
> index e96c317..c42b692 100644
> --- a/src/global/global_init.cc
> +++ b/src/global/global_init.cc
> @@ -94,6 +94,7 @@ void global_init(std::vector < const char * > *alt_def_args, std::vector < const
>    }
>    else if (ret) {
>      dout_emergency("global_init: error reading config file.\n");
> +    complain_about_parse_errors(cct, &parse_errors);
>      _exit(1);
>    }
>  
> @@ -109,6 +110,7 @@ void global_init(std::vector < const char * > *alt_def_args, std::vector < const
>    // Now we're ready to complain about config file parse errors
>    complain_about_parse_errors(cct, &parse_errors);
>  
> +#if !defined(_WIN32)
>    // signal stuff
>    int siglist[] = { SIGPIPE, 0 };
>    block_signals(siglist, NULL);
> @@ -118,11 +120,16 @@ void global_init(std::vector < const char * > *alt_def_args, std::vector < const
>  
>    if (g_conf->log_flush_on_exit)
>      g_ceph_context->_log->set_flush_on_exit();
> +#endif
>  
>    if (g_conf->run_dir.length() &&
>        code_env == CODE_ENVIRONMENT_DAEMON &&
>        !(flags & CINIT_FLAG_NO_DAEMON_ACTIONS)) {
> +#if !defined(_WIN32)
>      int r = ::mkdir(g_conf->run_dir.c_str(), 0755);
> +#else
> +    int r = ::mkdir(g_conf->run_dir.c_str());
> +#endif
>      if (r < 0 && errno != EEXIST) {
>        r = -errno;
>        derr << "warning: unable to create " << g_conf->run_dir << ": " << cpp_strerror(r) << dendl;
> @@ -172,6 +179,7 @@ void global_init_daemonize(CephContext *cct, int flags)
>    if (global_init_prefork(cct, flags) < 0)
>      return;
>  
> +#if !defined(_WIN32)
>    int ret = daemon(1, 1);
>    if (ret) {
>      ret = errno;
> @@ -179,6 +187,7 @@ void global_init_daemonize(CephContext *cct, int flags)
>  	 << cpp_strerror(ret) << dendl;
>      exit(1);
>    }
> +#endif
>  
>    global_init_postfork(cct, flags);
>  }
> diff --git a/src/global/signal_handler.cc b/src/global/signal_handler.cc
> index ffdc540..ded7b84 100644
> --- a/src/global/signal_handler.cc
> +++ b/src/global/signal_handler.cc
> @@ -19,7 +19,9 @@
>  #include "global/pidfile.h"
>  #include "global/signal_handler.h"
>  
> +#if !defined(_WIN32)
>  #include <poll.h>
> +#endif
>  #include <signal.h>
>  #include <sstream>
>  #include <stdlib.h>
> diff --git a/src/include/assert.h b/src/include/assert.h
> index 5584b8f..84d4c94 100644
> --- a/src/include/assert.h
> +++ b/src/include/assert.h
> @@ -6,6 +6,10 @@
>  #elif defined(__FreeBSD__)
>  #include <sys/cdefs.h>
>  #define	__GNUC_PREREQ(minor, major)	__GNUC_PREREQ__(minor, major)
> +#elif defined(_WIN32)
> +#include <sys/cdefs.h>
> +#define	__GNUC_PREREQ(minor, major)	__MINGW_GNUC_PREREQ(minor, major)
> +#define __STRING(x) #x
>  #endif
>  
>  #ifdef __CEPH__
> diff --git a/src/include/buffer.h b/src/include/buffer.h
> index 359a9ca..11e6253 100644
> --- a/src/include/buffer.h
> +++ b/src/include/buffer.h
> @@ -17,7 +17,7 @@
>  #if defined(__linux__)
>  #include <stdlib.h>
>  #include <linux/types.h>
> -#elif defined(__FreeBSD__)
> +#elif defined(__FreeBSD__) || defined(_WIN32)
>  #include <sys/types.h>
>  #include <stdlib.h>
>  #endif
> @@ -47,7 +47,7 @@
>  #include <stdint.h>
>  #include <string.h>
>  
> -#ifndef __CYGWIN__
> +#if !defined(__CYGWIN__) && !defined(_WIN32)
>  # include <sys/mman.h>
>  #endif
>  
> @@ -179,7 +179,7 @@ public:
>      bool at_buffer_head() const { return _off == 0; }
>      bool at_buffer_tail() const;
>  
> -    bool is_page_aligned() const { return ((long)c_str() & ~CEPH_PAGE_MASK) == 0; }
> +    bool is_page_aligned() const { return ((long)(intptr_t)c_str() & ~CEPH_PAGE_MASK) == 0; }
>      bool is_n_page_sized() const { return (length() & ~CEPH_PAGE_MASK) == 0; }
>  
>      // accessors
> diff --git a/src/include/compat.h b/src/include/compat.h
> index e766534..c38e92c 100644
> --- a/src/include/compat.h
> +++ b/src/include/compat.h
> @@ -20,6 +20,60 @@
>  #define	lseek64(fd, offset, whence)	lseek(fd, offset, whence)
>  #endif /* !__FreeBSD__ */
>  
> +#if defined(_WIN32)
> +#include <unistd.h>
> +/* winsock2.h needs to be included before windows.h */
> +#include <winsock2.h>
> +#include <windows.h>
> +typedef long long loff_t;
> +//#define PRId64 "I64d"
> +//#define PRIx64 "I64x"
> +#ifndef EBADMSG
> + #define EBADMSG 74
> +#endif
> +#ifndef EBADE
> + #define EBADE 52
> +#endif
> +
> +#define strerror_r(errnum, buf, buflen) ({strerror_s(buf, buflen, errnum); buf;})
> +
> +#define S_IFLNK 0120000
> +
> +#define IFTODT(mode) (((mode) & 0170000) >> 12)
> +
> +#define POLLIN   0x01
> +#define POLLPRI  0x02
> +#define POLLOUT  0x04
> +#define POLLERR  0x08
> +#define POLLHUP  0x10
> +#define POLLNVAL 0x20
> +
> +static __inline ssize_t pread(int fd, void *buf, size_t count, off_t offset) {
> +  off_t lseek_ret = lseek(fd, offset, SEEK_SET);
> +  if (lseek_ret != offset) {
> +    return -1;
> +  }
> +  return read(fd, buf, count);
> +}
> +
> +static __inline ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset) {
> +  off_t lseek_ret = lseek(fd, offset, SEEK_SET);
> +  if (lseek_ret != offset) {
> +    return -1;
> +  }
> +  return write(fd, buf, count);
> +}
> +
> +static __inline int fsync(int fd) {
> +  return (FlushFileBuffers((HANDLE)_get_osfhandle(fd))) ? 0 : -1;
> +}
> +
> +/* windows strtok uses thread lock storage */
> +#undef strtok_r
> +#define strtok_r(str, delim, saveptr) strtok_s(str, delim, saveptr);
> +
> +#endif
> +
>  #ifndef TEMP_FAILURE_RETRY
>  #define TEMP_FAILURE_RETRY(expression) ({     \
>    typeof(expression) __result;                \
> diff --git a/src/include/err.h b/src/include/err.h
> index ba4b32a..f5c89ab 100644
> --- a/src/include/err.h
> +++ b/src/include/err.h
> @@ -18,12 +18,12 @@ static inline void *ERR_PTR(long error)
>  
>  static inline long PTR_ERR(const void *ptr)
>  {
> -  return (long) ptr;
> +  return (long)(intptr_t) ptr;
>  }
>  
>  static inline long IS_ERR(const void *ptr)
>  {
> -  return IS_ERR_VALUE((unsigned long)ptr);
> +  return IS_ERR_VALUE((unsigned long)(uintptr_t)ptr);
>  }
>  
>  #endif
> diff --git a/src/include/int_types.h b/src/include/int_types.h
> index 98220e9..9d9c5dc 100644
> --- a/src/include/int_types.h
> +++ b/src/include/int_types.h
> @@ -33,12 +33,22 @@
>  #if !defined(PRIu64)
>  #  if defined(HAVE_INTTYPES_H) || defined(HAVE_GLIB)
>  /* If we have inttypes or glib, assume we have 64-bit long long int */
> -#    define PRIu64 "llu"
> -#    define PRIi64 "lli"
> -#    define PRIx64 "llx"
> -#    define PRIX64 "llX"
> -#    define PRIo64 "llo"
> -#    define PRId64 "lld"
> +#    if !defined(_WIN32)
> +#      define PRIu64 "llu"
> +#      define PRIi64 "lli"
> +#      define PRIx64 "llx"
> +#      define PRIX64 "llX"
> +#      define PRIo64 "llo"
> +#      define PRId64 "lld"
> +#    else
> +/* not sure how many of these actually work */
> +#      define PRIu64 "I64d"
> +#      define PRIi64 "I64i"
> +#      define PRIx64 "I64x"
> +#      define PRIX64 "I64X"
> +#      define PRIo64 "I64o"
> +#      define PRId64 "I64d"
> +#    endif
>  #  else
>  /* Assume that we don't have long long, so use long int modifiers */
>  #    define PRIu64 "lu"
> diff --git a/src/include/ipaddr.h b/src/include/ipaddr.h
> index cac13d6..14943df 100644
> --- a/src/include/ipaddr.h
> +++ b/src/include/ipaddr.h
> @@ -1,9 +1,13 @@
>  #ifndef CEPH_IPADDR_H
>  #define CEPH_IPADDR_H
>  
> -#include <netinet/in.h>
> +#if !defined(_WIN32)
> + #include <netinet/in.h>
> + #include <ifaddrs.h>
> +#else
> + #include <winsock2.h>
> +#endif
>  #include <sys/types.h>
> -#include <ifaddrs.h>
>  
>  /*
>    Find an IP address that is in the wanted subnet.
> diff --git a/src/include/msgr.h b/src/include/msgr.h
> index 5854682..9a71252 100644
> --- a/src/include/msgr.h
> +++ b/src/include/msgr.h
> @@ -2,7 +2,11 @@
>  #define CEPH_MSGR_H
>  
>  #ifdef __cplusplus
> -#include <sys/socket.h> // for struct sockaddr_storage
> +#if defined(_WIN32)
> + #include <winsock2.h>
> +#else
> + #include <sys/socket.h> // for struct sockaddr_storage
> +#endif
>  #endif
>  
>  /*
> diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
> index a67b85e..77c181c 100644
> --- a/src/include/rados/librados.h
> +++ b/src/include/rados/librados.h
> @@ -5,7 +5,11 @@
>  extern "C" {
>  #endif
>  
> -#include <netinet/in.h>
> +#if defined(_WIN32)
> + #include <winsock2.h>
> +#else
> + #include <netinet/in.h>
> +#endif
>  #if defined(__linux__)
>  #include <linux/types.h>
>  #elif defined(__FreeBSD__)
> diff --git a/src/include/rbd/librbd.h b/src/include/rbd/librbd.h
> index 5be8203..0923668 100644
> --- a/src/include/rbd/librbd.h
> +++ b/src/include/rbd/librbd.h
> @@ -19,10 +19,14 @@
>  extern "C" {
>  #endif
>  
> -#include <netinet/in.h>
>  #if defined(__linux__)
> +#include <netinet/in.h>
>  #include <linux/types.h>
>  #elif defined(__FreeBSD__)
> +#include <netinet/in.h>
> +#include <sys/types.h>
> +#elif defined(_WIN32)
> +#include <winsock.h>
>  #include <sys/types.h>
>  #endif
>  #include <string.h>
> diff --git a/src/include/statlite.h b/src/include/statlite.h
> index 2ab3a94..cb282b2 100644
> --- a/src/include/statlite.h
> +++ b/src/include/statlite.h
> @@ -11,6 +11,14 @@ extern "C" {
>  #include <unistd.h>
>  #include <dirent.h>
>  
> +#if defined(_WIN32)
> + typedef uint32_t nlink_t;
> + typedef uint16_t uid_t;
> + typedef uint16_t gid_t;
> + typedef uint64_t blksize_t;
> + typedef uint32_t blkcnt_t;
> +#endif
> +
>  struct statlite {
>    dev_t         st_dev;      /* device */
>    ino_t         st_ino;      /* inode */
> diff --git a/src/include/types.h b/src/include/types.h
> index bc6e077..4ece87e 100644
> --- a/src/include/types.h
> +++ b/src/include/types.h
> @@ -20,7 +20,12 @@
>  
>  #include "uuid.h"
>  
> -#include <netinet/in.h>
> +#if defined(_WIN32)
> + #include <winsock2.h>
> + #include <ws2ipdef.h>
> +#else
> + #include <netinet/in.h>
> +#endif
>  #include <fcntl.h>
>  #include <string.h>
>  
> @@ -103,7 +108,7 @@ CEPH_HASH_NAMESPACE_START
>    };
>  #endif
>  
> -#if !defined(__LP64__) || defined(__APPLE__)
> +#if !defined(_WIN32) && (!defined(__LP64__) || defined(__APPLE__))
>  /*
>   * FIXME: not sure how to test for this robustly yet, but on Mavericks with
>   * C++11 these definitions are present.
> diff --git a/src/include/utime.h b/src/include/utime.h
> index 1a74a85..d36fb3f 100644
> --- a/src/include/utime.h
> +++ b/src/include/utime.h
> @@ -107,6 +107,13 @@ public:
>      tv.tv_nsec = t->tv_nsec;
>    }
>  
> +#if defined(_WIN32)
> +  /* this is required because ::gmtime_r is a macro that calls gmtime, not ::gmtime */
> +  static struct tm *gmtime(const time_t *timep) {
> +    return ::gmtime(timep);
> +  }
> +#endif
> +
>    utime_t round_to_minute() {
>      struct tm bdt;
>      time_t tt = sec();
> @@ -172,6 +179,9 @@ public:
>      return out;
>    }
>  
> +  static char *asctime(const struct tm *tm) {
> +    return ::asctime(tm);
> +  }
>    // output
>    ostream& asctime(ostream& out) const {
>      out.setf(std::ios::right);
> @@ -199,6 +209,10 @@ public:
>      return out;
>    }
>    
> +  static struct tm *localtime(const time_t *timep) {
> +    return ::localtime(timep);
> +  }
> +
>    ostream& localtime(ostream& out) const {
>      out.setf(std::ios::right);
>      char oldfill = out.fill();
> @@ -238,6 +252,7 @@ public:
>  		    bdt.tm_hour, bdt.tm_min, bdt.tm_sec, usec());
>    }
>  
> +#if 0
>    static time_t my_timegm (struct tm *tm) {
>      time_t ret;
>      char *tz;
> @@ -307,6 +322,7 @@ public:
>  
>      return 0;
>    }
> +#endif
>  };
>  WRITE_CLASS_ENCODER(utime_t)
>  
> diff --git a/src/include/uuid.h b/src/include/uuid.h
> index 942b807..201ac76 100644
> --- a/src/include/uuid.h
> +++ b/src/include/uuid.h
> @@ -8,6 +8,70 @@
>  #include "encoding.h"
>  #include <ostream>
>  
> +#if defined(_WIN32)
> +
> +#include <boost/lexical_cast.hpp>
> +#include <boost/uuid/uuid.hpp>
> +#include <boost/uuid/uuid_generators.hpp>
> +#include <boost/uuid/uuid_io.hpp>
> +#include <string>
> +
> +struct uuid_d {
> +  boost::uuids::uuid uuid;
> +
> +  uuid_d() {
> +    uuid = boost::uuids::nil_uuid();
> +  }
> +
> +  bool is_zero() const {
> +    return uuid.is_nil();
> +    //return boost::uuids::uuid::is_nil(uuid);
> +  }
> +
> +  void generate_random() {
> +    boost::uuids::random_generator gen;
> +    uuid = gen();
> +  }
> +  
> +  bool parse(const char *s) {
> +    boost::uuids::string_generator gen;
> +    uuid = gen(s);
> +    return true;
> +    // what happens if parse fails?
> +  }
> +  void print(char *s) {
> +    std::string str = boost::lexical_cast<std::string>(uuid);
> +    memcpy(s, str.c_str(), 37);
> +  }
> +
> +  void encode(bufferlist& bl) const {
> +    ::encode_raw(uuid, bl);
> +  }
> +  void decode(bufferlist::iterator& p) const {
> +    ::decode_raw(uuid, p);
> +  }
> +
> +  uuid_d& operator=(const uuid_d& r) {
> +    uuid = r.uuid;
> +    return *this;
> +  }
> +};
> +WRITE_CLASS_ENCODER(uuid_d)
> +
> +inline std::ostream& operator<<(std::ostream& out, const uuid_d& u) {
> +  //char b[37];
> +  //uuid_unparse(u.uuid, b);
> +  return out << u.uuid;
> +}
> +
> +inline bool operator==(const uuid_d& l, const uuid_d& r) {
> +  return l.uuid == r.uuid;
> +}
> +
> +inline bool operator!=(const uuid_d& l, const uuid_d& r) {
> +  return l.uuid != r.uuid;
> +}
> +#else
>  extern "C" {
>  #include <uuid/uuid.h>
>  #include <unistd.h>
> @@ -56,6 +120,6 @@ inline bool operator==(const uuid_d& l, const uuid_d& r) {
>  inline bool operator!=(const uuid_d& l, const uuid_d& r) {
>    return uuid_compare(l.uuid, r.uuid) != 0;
>  }
> -
> +#endif
>  
>  #endif
> diff --git a/src/librados/librados.cc b/src/librados/librados.cc
> index 95abbc2..c4bbb6a 100644
> --- a/src/librados/librados.cc
> +++ b/src/librados/librados.cc
> @@ -1054,7 +1054,7 @@ int librados::IoCtx::lock_exclusive(const std::string &oid, const std::string &n
>    if (duration)
>      dur.set_from_timeval(duration);
>  
> -  return rados::cls::lock::lock(this, oid, name, LOCK_EXCLUSIVE, cookie, "",
> +  return rados::cls::lock::lock(this, oid, name, xLOCK_EXCLUSIVE, cookie, "",
>  		  		description, dur, flags);
>  }
>  
> @@ -1113,7 +1113,7 @@ int librados::IoCtx::list_lockers(const std::string &oid, const std::string &nam
>    if (tag)
>      *tag = tmp_tag;
>    if (exclusive) {
> -    if (tmp_type == LOCK_EXCLUSIVE)
> +    if (tmp_type == xLOCK_EXCLUSIVE)
>        *exclusive = 1;
>      else
>        *exclusive = 0;
> diff --git a/src/librbd/internal.cc b/src/librbd/internal.cc
> index 4185f36..0915c7b 100644
> --- a/src/librbd/internal.cc
> +++ b/src/librbd/internal.cc
> @@ -3,6 +3,9 @@
>  #include "include/int_types.h"
>  
>  #include <errno.h>
> +#if defined(_WIN32)
> + #define        ESTALE          116     /* Stale NFS file handle */
> +#endif
>  #include <limits.h>
>  
>  #include "common/ceph_context.h"
> @@ -1679,7 +1682,7 @@ reprotect_and_return_err:
>  		       << dendl;
>  	    return r;
>  	  }
> -	  ictx->exclusive_locked = (lock_type == LOCK_EXCLUSIVE);
> +	  ictx->exclusive_locked = (lock_type == xLOCK_EXCLUSIVE);
>  	  ictx->order = ictx->header.options.order;
>  	  ictx->size = ictx->header.image_size;
>  	  ictx->object_prefix = ictx->header.block_name;
> @@ -2257,7 +2260,7 @@ reprotect_and_return_err:
>       */
>      RWLock::RLocker locker(ictx->md_lock);
>      r = rados::cls::lock::lock(&ictx->md_ctx, ictx->header_oid, RBD_LOCK_NAME,
> -			       exclusive ? LOCK_EXCLUSIVE : LOCK_SHARED,
> +			       exclusive ? xLOCK_EXCLUSIVE : LOCK_SHARED,
>  			       cookie, tag, "", utime_t(), 0);
>      if (r < 0)
>        return r;
> diff --git a/src/log/Log.cc b/src/log/Log.cc
> index b597b0e..b5ae1d6 100644
> --- a/src/log/Log.cc
> +++ b/src/log/Log.cc
> @@ -4,7 +4,8 @@
>  #include "Log.h"
>  
>  #include <errno.h>
> -#include <syslog.h>
> +//#include <syslog.h>
> +#include "include/compat.h"
>  
>  #include <iostream>
>  #include <sstream>
> @@ -82,6 +83,7 @@ Log::~Log()
>  
>  ///
>  
> +#if !defined(_WIN32)
>  void Log::set_flush_on_exit()
>  {
>    // Make sure we flush on shutdown.  We do this by deliberately
> @@ -97,6 +99,7 @@ void Log::set_flush_on_exit()
>  #endif
>    }
>  }
> +#endif
>  
>  void Log::set_max_new(int n)
>  {
> @@ -221,10 +224,11 @@ void Log::_flush(EntryQueue *t, EntryQueue *requeue, bool crash)
>  	if (r < 0)
>  	  cerr << "problem writing to " << m_log_file << ": " << cpp_strerror(r) << std::endl;
>        }
> -
> +#if !defined(_WIN32)
>        if (do_syslog) {
>  	syslog(LOG_USER, "%s%s", buf, s.c_str());
>        }
> +#endif
>  
>        if (do_stderr) {
>  	cerr << buf << s << std::endl;
> @@ -244,9 +248,11 @@ void Log::_log_message(const char *s, bool crash)
>      if (r < 0)
>        cerr << "problem writing to " << m_log_file << ": " << cpp_strerror(r) << std::endl;
>    }
> +#if !defined(_WIN32)
>    if ((crash ? m_syslog_crash : m_syslog_log) >= 0) {
>      syslog(LOG_USER, "%s", s);
>    }
> +#endif
>    
>    if ((crash ? m_stderr_crash : m_stderr_log) >= 0) {
>      cerr << s << std::endl;
> diff --git a/src/mds/CDentry.h b/src/mds/CDentry.h
> index e40854a..3bf8c53 100644
> --- a/src/mds/CDentry.h
> +++ b/src/mds/CDentry.h
> @@ -170,7 +170,7 @@ public:
>    static LockType versionlock_type;
>  
>    SimpleLock lock;
> -  LocalLock versionlock;
> +  xLocalLock versionlock;
>  
>   public:
>    // cons
> diff --git a/src/mds/CInode.h b/src/mds/CInode.h
> index 1c2a933..5523aca 100644
> --- a/src/mds/CInode.h
> +++ b/src/mds/CInode.h
> @@ -616,7 +616,7 @@ public:
>    static LockType flocklock_type;
>    static LockType policylock_type;
>  
> -  LocalLock  versionlock;
> +  xLocalLock  versionlock;
>    SimpleLock authlock;
>    SimpleLock linklock;
>    ScatterLock dirfragtreelock;
> diff --git a/src/mds/LocalLock.h b/src/mds/LocalLock.h
> index c797ea7..33bbba0 100644
> --- a/src/mds/LocalLock.h
> +++ b/src/mds/LocalLock.h
> @@ -18,11 +18,12 @@
>  
>  #include "SimpleLock.h"
>  
> -class LocalLock : public SimpleLock {
> +/* LocalLock is the name of a Win32 API */
> +class xLocalLock : public SimpleLock {
>  public:
>    client_t last_wrlock_client;
>    
> -  LocalLock(MDSCacheObject *o, LockType *t) : 
> +  xLocalLock(MDSCacheObject *o, LockType *t) : 
>      SimpleLock(o, t) {
>      set_state(LOCK_LOCK); // always.
>    }
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index e11bbd8..e361c7f 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -1243,7 +1243,7 @@ void Locker::wrlock_force(SimpleLock *lock, Mutation *mut)
>  {
>    if (lock->get_type() == CEPH_LOCK_IVERSION ||
>        lock->get_type() == CEPH_LOCK_DVERSION)
> -    return local_wrlock_grab(static_cast<LocalLock*>(lock), mut);
> +    return local_wrlock_grab(static_cast<xLocalLock*>(lock), mut);
>  
>    dout(7) << "wrlock_force  on " << *lock
>  	  << " on " << *lock->get_parent() << dendl;  
> @@ -1256,7 +1256,7 @@ bool Locker::wrlock_start(SimpleLock *lock, MDRequest *mut, bool nowait)
>  {
>    if (lock->get_type() == CEPH_LOCK_IVERSION ||
>        lock->get_type() == CEPH_LOCK_DVERSION)
> -    return local_wrlock_start(static_cast<LocalLock*>(lock), mut);
> +    return local_wrlock_start(static_cast<xLocalLock*>(lock), mut);
>  
>    dout(10) << "wrlock_start " << *lock << " on " << *lock->get_parent() << dendl;
>  
> @@ -1319,7 +1319,7 @@ void Locker::wrlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
>  {
>    if (lock->get_type() == CEPH_LOCK_IVERSION ||
>        lock->get_type() == CEPH_LOCK_DVERSION)
> -    return local_wrlock_finish(static_cast<LocalLock*>(lock), mut);
> +    return local_wrlock_finish(static_cast<xLocalLock*>(lock), mut);
>  
>    dout(7) << "wrlock_finish on " << *lock << " on " << *lock->get_parent() << dendl;
>    lock->put_wrlock();
> @@ -1389,7 +1389,7 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
>  {
>    if (lock->get_type() == CEPH_LOCK_IVERSION ||
>        lock->get_type() == CEPH_LOCK_DVERSION)
> -    return local_xlock_start(static_cast<LocalLock*>(lock), mut);
> +    return local_xlock_start(static_cast<xLocalLock*>(lock), mut);
>  
>    dout(7) << "xlock_start on " << *lock << " on " << *lock->get_parent() << dendl;
>    client_t client = mut->get_client();
> @@ -1488,7 +1488,7 @@ void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
>  {
>    if (lock->get_type() == CEPH_LOCK_IVERSION ||
>        lock->get_type() == CEPH_LOCK_DVERSION)
> -    return local_xlock_finish(static_cast<LocalLock*>(lock), mut);
> +    return local_xlock_finish(static_cast<xLocalLock*>(lock), mut);
>  
>    dout(10) << "xlock_finish on " << *lock << " " << *lock->get_parent() << dendl;
>  
> @@ -4070,7 +4070,7 @@ void Locker::scatter_tempsync(ScatterLock *lock, bool *need_issue)
>  // ==========================================================================
>  // local lock
>  
> -void Locker::local_wrlock_grab(LocalLock *lock, Mutation *mut)
> +void Locker::local_wrlock_grab(xLocalLock *lock, Mutation *mut)
>  {
>    dout(7) << "local_wrlock_grab  on " << *lock
>  	  << " on " << *lock->get_parent() << dendl;  
> @@ -4083,7 +4083,7 @@ void Locker::local_wrlock_grab(LocalLock *lock, Mutation *mut)
>    mut->locks.insert(lock);
>  }
>  
> -bool Locker::local_wrlock_start(LocalLock *lock, MDRequest *mut)
> +bool Locker::local_wrlock_start(xLocalLock *lock, MDRequest *mut)
>  {
>    dout(7) << "local_wrlock_start  on " << *lock
>  	  << " on " << *lock->get_parent() << dendl;  
> @@ -4101,7 +4101,7 @@ bool Locker::local_wrlock_start(LocalLock *lock, MDRequest *mut)
>    }
>  }
>  
> -void Locker::local_wrlock_finish(LocalLock *lock, Mutation *mut)
> +void Locker::local_wrlock_finish(xLocalLock *lock, Mutation *mut)
>  {
>    dout(7) << "local_wrlock_finish  on " << *lock
>  	  << " on " << *lock->get_parent() << dendl;  
> @@ -4115,7 +4115,7 @@ void Locker::local_wrlock_finish(LocalLock *lock, Mutation *mut)
>    }
>  }
>  
> -bool Locker::local_xlock_start(LocalLock *lock, MDRequest *mut)
> +bool Locker::local_xlock_start(xLocalLock *lock, MDRequest *mut)
>  {
>    dout(7) << "local_xlock_start  on " << *lock
>  	  << " on " << *lock->get_parent() << dendl;  
> @@ -4132,7 +4132,7 @@ bool Locker::local_xlock_start(LocalLock *lock, MDRequest *mut)
>    return true;
>  }
>  
> -void Locker::local_xlock_finish(LocalLock *lock, Mutation *mut)
> +void Locker::local_xlock_finish(xLocalLock *lock, Mutation *mut)
>  {
>    dout(7) << "local_xlock_finish  on " << *lock
>  	  << " on " << *lock->get_parent() << dendl;  
> diff --git a/src/mds/Locker.h b/src/mds/Locker.h
> index 0c9931a..98f4f9e 100644
> --- a/src/mds/Locker.h
> +++ b/src/mds/Locker.h
> @@ -51,7 +51,7 @@ class LogSegment;
>  
>  class SimpleLock;
>  class ScatterLock;
> -class LocalLock;
> +class xLocalLock;
>  class MDCache;
>  
>  #include "SimpleLock.h"
> @@ -230,12 +230,12 @@ public:
>  
>    // local
>  public:
> -  void local_wrlock_grab(LocalLock *lock, Mutation *mut);
> +  void local_wrlock_grab(xLocalLock *lock, Mutation *mut);
>  protected:
> -  bool local_wrlock_start(LocalLock *lock, MDRequest *mut);
> -  void local_wrlock_finish(LocalLock *lock, Mutation *mut);
> -  bool local_xlock_start(LocalLock *lock, MDRequest *mut);
> -  void local_xlock_finish(LocalLock *lock, Mutation *mut);
> +  bool local_wrlock_start(xLocalLock *lock, MDRequest *mut);
> +  void local_wrlock_finish(xLocalLock *lock, Mutation *mut);
> +  bool local_xlock_start(xLocalLock *lock, MDRequest *mut);
> +  void local_xlock_finish(xLocalLock *lock, Mutation *mut);
>  
>  
>    // file
> diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
> index 53819de..cd4d86d 100644
> --- a/src/mds/mdstypes.h
> +++ b/src/mds/mdstypes.h
> @@ -11,6 +11,8 @@
>  #include <map>
>  using namespace std;
>  
> +#include "include/compat.h"
> +
>  #include "common/config.h"
>  #include "common/Clock.h"
>  #include "common/DecayCounter.h"
> diff --git a/src/messages/MAuthReply.h b/src/messages/MAuthReply.h
> index 76359a5..a3b10d5 100644
> --- a/src/messages/MAuthReply.h
> +++ b/src/messages/MAuthReply.h
> @@ -16,6 +16,7 @@
>  #define CEPH_MAUTHREPLY_H
>  
>  #include "msg/Message.h"
> +#include "include/compat.h"
>  
>  struct MAuthReply : public Message {
>    __u32 protocol;
> diff --git a/src/messages/MCommand.h b/src/messages/MCommand.h
> index e2fe075..a92a535 100644
> --- a/src/messages/MCommand.h
> +++ b/src/messages/MCommand.h
> @@ -16,7 +16,7 @@
>  #define CEPH_MCOMMAND_H
>  
>  #include <vector>
> -#include <uuid/uuid.h>
> +//#include <uuid/uuid.h>
>  
>  #include "msg/Message.h"
>  
> diff --git a/src/messages/MGetPoolStats.h b/src/messages/MGetPoolStats.h
> index acf9637..b407d66 100644
> --- a/src/messages/MGetPoolStats.h
> +++ b/src/messages/MGetPoolStats.h
> @@ -16,7 +16,7 @@
>  #ifndef CEPH_MGETPOOLSTATS_H
>  #define CEPH_MGETPOOLSTATS_H
>  
> -#include <uuid/uuid.h>
> +//#include <uuid/uuid.h>
>  
>  #include "messages/PaxosServiceMessage.h"
>  
> diff --git a/src/messages/MGetPoolStatsReply.h b/src/messages/MGetPoolStatsReply.h
> index 719d5b8..f312e80 100644
> --- a/src/messages/MGetPoolStatsReply.h
> +++ b/src/messages/MGetPoolStatsReply.h
> @@ -16,7 +16,7 @@
>  #ifndef CEPH_MGETPOOLSTATSREPLY_H
>  #define CEPH_MGETPOOLSTATSREPLY_H
>  
> -#include <uuid/uuid.h>
> +//#include <uuid/uuid.h>
>  
>  class MGetPoolStatsReply : public PaxosServiceMessage {
>  public:
> diff --git a/src/messages/MLog.h b/src/messages/MLog.h
> index c71f56b..5d35f8a 100644
> --- a/src/messages/MLog.h
> +++ b/src/messages/MLog.h
> @@ -19,7 +19,7 @@
>  #include "messages/PaxosServiceMessage.h"
>  
>  #include <deque>
> -#include <uuid/uuid.h>
> +//#include <uuid/uuid.h>
>  
>  class MLog : public PaxosServiceMessage {
>  public:
> diff --git a/src/messages/MLogAck.h b/src/messages/MLogAck.h
> index 8022e7c..c111052 100644
> --- a/src/messages/MLogAck.h
> +++ b/src/messages/MLogAck.h
> @@ -15,8 +15,6 @@
>  #ifndef CEPH_MLOGACK_H
>  #define CEPH_MLOGACK_H
>  
> -#include <uuid/uuid.h>
> -
>  class MLogAck : public Message {
>  public:
>    uuid_d fsid;
> diff --git a/src/messages/MMDSBeacon.h b/src/messages/MMDSBeacon.h
> index 64d442b..c4873ef 100644
> --- a/src/messages/MMDSBeacon.h
> +++ b/src/messages/MMDSBeacon.h
> @@ -21,7 +21,7 @@
>  
>  #include "mds/MDSMap.h"
>  
> -#include <uuid/uuid.h>
> +//#include <uuid/uuid.h>
>  
>  class MMDSBeacon : public PaxosServiceMessage {
>  
> diff --git a/src/messages/MMDSMap.h b/src/messages/MMDSMap.h
> index 66566d0..c7c6e5e 100644
> --- a/src/messages/MMDSMap.h
> +++ b/src/messages/MMDSMap.h
> @@ -20,7 +20,7 @@
>  #include "mds/MDSMap.h"
>  #include "include/ceph_features.h"
>  
> -#include <uuid/uuid.h>
> +//#include <uuid/uuid.h>
>  
>  class MMDSMap : public Message {
>   public:
> diff --git a/src/messages/MOSDOpReply.h b/src/messages/MOSDOpReply.h
> index c0e989f..75a4a35 100644
> --- a/src/messages/MOSDOpReply.h
> +++ b/src/messages/MOSDOpReply.h
> @@ -21,6 +21,7 @@
>  #include "MOSDOp.h"
>  #include "os/ObjectStore.h"
>  
> +#include "include/compat.h"
>  /*
>   * OSD op reply
>   *
> diff --git a/src/messages/MStatfs.h b/src/messages/MStatfs.h
> index 61370a9..f81bd37 100644
> --- a/src/messages/MStatfs.h
> +++ b/src/messages/MStatfs.h
> @@ -16,7 +16,7 @@
>  #ifndef CEPH_MSTATFS_H
>  #define CEPH_MSTATFS_H
>  
> -#include <sys/statvfs.h>    /* or <sys/statfs.h> */
> +//#include <sys/statvfs.h>    /* or <sys/statfs.h> */
>  #include "messages/PaxosServiceMessage.h"
>  
>  class MStatfs : public PaxosServiceMessage {
> diff --git a/src/messages/MStatfsReply.h b/src/messages/MStatfsReply.h
> index 8ceec9c..40a5bdd 100644
> --- a/src/messages/MStatfsReply.h
> +++ b/src/messages/MStatfsReply.h
> @@ -22,7 +22,7 @@ public:
>  
>    MStatfsReply() : Message(CEPH_MSG_STATFS_REPLY) {}
>    MStatfsReply(uuid_d &f, tid_t t, epoch_t epoch) : Message(CEPH_MSG_STATFS_REPLY) {
> -    memcpy(&h.fsid, f.uuid, sizeof(h.fsid));
> +    memcpy(&h.fsid, &f.uuid, sizeof(h.fsid));
>      header.tid = t;
>      h.version = epoch;
>    }
> diff --git a/src/msg/Accepter.cc b/src/msg/Accepter.cc
> index d6e94d1..ab7c32d 100644
> --- a/src/msg/Accepter.cc
> +++ b/src/msg/Accepter.cc
> @@ -12,11 +12,17 @@
>   * 
>   */
>  
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include "include/compat.h"
> +#if !defined(_WIN32)
> + #include <sys/socket.h>
> + #include <netinet/tcp.h>
> + #include <poll.h>
>  #include <sys/uio.h>
> +#else
> + #include <winsock2.h>
> + #include <ws2tcpip.h>
> +#endif
>  #include <limits.h>
> -#include <poll.h>
>  
>  #include "Accepter.h"
>  #include "SimpleMessenger.h"
> @@ -75,7 +81,7 @@ int Accepter::bind(const entity_addr_t &bind_addr, const set<int>& avoid_ports)
>  
>      // reuse addr+port when possible
>      int on = 1;
> -    rc = ::setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on));
> +    rc = ::setsockopt(listen_sd, SOL_SOCKET, SO_REUSEADDR, (char *)&on, sizeof(on));
>      if (rc < 0) {
>        ldout(msgr->cct,0) << "accepter.bind unable to setsockopt: "
>  			 << cpp_strerror(errno) << dendl;
> diff --git a/src/msg/Pipe.cc b/src/msg/Pipe.cc
> index ebf0cae..7ea2147 100644
> --- a/src/msg/Pipe.cc
> +++ b/src/msg/Pipe.cc
> @@ -12,11 +12,16 @@
>   * 
>   */
>  
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> -#include <sys/uio.h>
> -#include <limits.h>
> -#include <poll.h>
> +#if !defined(_WIN32)
> + #include <sys/socket.h>
> + #include <netinet/tcp.h>
> + #include <sys/uio.h>
> + #include <limits.h>
> + #include <poll.h>
> +#else
> + #include <winsock2.h>
> + #include "include/compat.h"
> +#endif
>  
>  #include "Message.h"
>  #include "Pipe.h"
> @@ -52,16 +57,21 @@ ostream& Pipe::_pipe_prefix(std::ostream *_dout) {
>  # define MSG_MORE 0
>  #endif
>  
> -#ifndef MSG_NOSIGNAL
> -# ifdef SO_NOSIGPIPE
> -#  define MSG_NOSIGNAL SO_NOSIGPIPE
> -# else
> -#  error "Don't know how to block SIGPIPE
> +#if !defined(_WIN32)
> +# ifndef MSG_NOSIGNAL
> +#  ifdef SO_NOSIGPIPE
> +#   define MSG_NOSIGNAL SO_NOSIGPIPE
> +#  else
> +#   error "Don't know how to block SIGPIPE"
> +#  endif
>  # endif
> +#else
> +# define MSG_NOSIGNAL 1
>  #endif
>  
>  
>  
> +
>  /**************************************
>   * Pipe
>   */
> @@ -760,7 +770,7 @@ void Pipe::set_socket_options()
>    }
>    if (msgr->cct->_conf->ms_tcp_rcvbuf) {
>      int size = msgr->cct->_conf->ms_tcp_rcvbuf;
> -    int r = ::setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void*)&size, sizeof(size));
> +    int r = ::setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (char*)&size, sizeof(size));
>      if (r < 0)  {
>        r = -errno;
>        ldout(msgr->cct,0) << "couldn't set SO_RCVBUF to " << size << ": " << cpp_strerror(r) << dendl;
> @@ -800,22 +810,37 @@ int Pipe::connect()
>      ::close(sd);
>  
>    char buf[80];
> +  unsigned long nonblocking;
>  
>    // create socket?
>    sd = ::socket(peer_addr.get_family(), SOCK_STREAM, 0);
> +  //sd = ::socket(AF_INET, SOCK_STREAM, 0);
>    if (sd < 0) {
>      lderr(msgr->cct) << "connect couldn't created socket " << strerror_r(errno, buf, sizeof(buf)) << dendl;
>      goto fail;
>    }
> -
>    // connect!
>    ldout(msgr->cct,10) << "connecting to " << peer_addr << dendl;
>    rc = ::connect(sd, (sockaddr*)&peer_addr.addr, peer_addr.addr_size());
> +#if !defined(_WIN32)
>    if (rc < 0) {
>      ldout(msgr->cct,2) << "connect error " << peer_addr
>  	     << ", " << errno << ": " << strerror_r(errno, buf, sizeof(buf)) << dendl;
>      goto fail;
>    }
> +#else
> +  if (rc == SOCKET_ERROR) {
> +    ldout(msgr->cct,2) << "connect error " << peer_addr
> +	     << ", " << WSAGetLastError() << ": <insert error text here)" << dendl;
> +    goto fail;
> +  }
> +#endif
> +
> +#if defined(_WIN32)
> +  /* set to nonblocking after connect */
> +  nonblocking = 1;
> +  ioctlsocket(sd, FIONBIO, &nonblocking);
> +#endif
>  
>    set_socket_options();
>  
> @@ -1929,6 +1954,35 @@ int Pipe::read_message(Message **pm)
>    return ret;
>  }
>  
> +static ssize_t sendmsg(int sd, const struct msghdr *msg, int flags)
> +{
> +  int i;
> +  ssize_t sent = 0;
> +  int ret;
> +
> +  for (i = 0; i < msg->msg_iovlen; i++) {
> +    fd_set writefds;
> +    FD_ZERO(&writefds);
> +    FD_SET(sd, &writefds);
> +    ret = select(0, NULL, &writefds, NULL, NULL);
> +    if (ret != 1) {
> +      /* check error and... */
> +      return -1;
> +    }
> +    if (send(sd, (char *)msg->msg_iov[i].iov_base, msg->msg_iov[i].iov_len, 0) == SOCKET_ERROR) {
> +      if (sent > 0) {
> +        return sent;
> +      } else {
> +        /* get error and set errno... later */
> +        return -1;
> +      }
> +    } else {
> +      sent += msg->msg_iov[i].iov_len;
> +    }
> +  }
> +  return sent;
> +}
> +
>  int Pipe::do_sendmsg(struct msghdr *msg, int len, bool more)
>  {
>    char buf[80];
> @@ -1940,7 +1994,6 @@ int Pipe::do_sendmsg(struct msghdr *msg, int len, bool more)
>  	l += msg->msg_iov[i].iov_len;
>        assert(l == len);
>      }
> -
>      int r = ::sendmsg(sd, msg, MSG_NOSIGNAL | (more ? MSG_MORE : 0));
>      if (r == 0) 
>        ldout(msgr->cct,10) << "do_sendmsg hmm do_sendmsg got r==0!" << dendl;
> @@ -2021,7 +2074,6 @@ int Pipe::write_keepalive()
>    return 0;
>  }
>  
> -
>  int Pipe::write_message(ceph_msg_header& header, ceph_msg_footer& footer, bufferlist& blist)
>  {
>    int ret;
> @@ -2142,7 +2194,6 @@ int Pipe::write_message(ceph_msg_header& header, ceph_msg_footer& footer, buffer
>    goto out;
>  }
>  
> -
>  int Pipe::tcp_read(char *buf, int len)
>  {
>    if (sd < 0)
> @@ -2176,6 +2227,7 @@ int Pipe::tcp_read_wait()
>  {
>    if (sd < 0)
>      return -1;
> +#if !defined(_WIN32)
>    struct pollfd pfd;
>    short evmask;
>    pfd.fd = sd;
> @@ -2198,10 +2250,25 @@ int Pipe::tcp_read_wait()
>      return -1;
>  
>    return 0;
> +#else
> +  fd_set readfds;
> +  int ret;
> +
> +  FD_ZERO(&readfds);
> +  FD_SET(sd, &readfds);
> +  
> +  ret = ::select(0, &readfds, NULL, NULL, NULL);
> +  if (ret == 1) {
> +    return 0;
> +  } else {
> +    return 1; /* does the actual error matter here? */
> +  }
> +#endif
>  }
>  
>  int Pipe::tcp_read_nonblocking(char *buf, int len)
>  {
> +#if !defined(_WIN32)
>  again:
>    int got = ::recv( sd, buf, len, MSG_DONTWAIT );
>    if (got < 0) {
> @@ -2220,12 +2287,23 @@ again:
>      return -1;
>    }
>    return got;
> +#else
> +  int got = ::recv(sd, buf, len, 0);
> +  if (got == SOCKET_ERROR) {
> +    /* check if this is an againable error */
> +    return -1;
> +  } else if (got == 0) {
> +    return -1;
> +  }
> +  return got;
> +#endif
>  }
>  
>  int Pipe::tcp_write(const char *buf, int len)
>  {
>    if (sd < 0)
>      return -1;
> +#if !defined(_WIN32)
>    struct pollfd pfd;
>    pfd.fd = sd;
>    pfd.events = POLLOUT | POLLHUP | POLLNVAL | POLLERR;
> @@ -2239,12 +2317,14 @@ int Pipe::tcp_write(const char *buf, int len)
>        ::shutdown(sd, SHUT_RDWR);
>      }
>    }
> -
>    if (poll(&pfd, 1, -1) < 0)
>      return -1;
>  
>    if (!(pfd.revents & POLLOUT))
>      return -1;
> +#else
> +  /* checking is handled in our sendmsg */
> +#endif
>  
>    //lgeneric_dout(cct, DBL) << "tcp_write writing " << len << dendl;
>    assert(len > 0);
> diff --git a/src/msg/Pipe.h b/src/msg/Pipe.h
> index 6c91395..c2a5a90 100644
> --- a/src/msg/Pipe.h
> +++ b/src/msg/Pipe.h
> @@ -19,6 +19,24 @@
>  #include "Messenger.h"
>  #include "auth/AuthSessionHandler.h"
>  
> +#if defined(_WIN32)
> + /* winsock has different names for the same things */
> + #define SHUT_RD   SD_RECEIVE
> + #define SHUT_WR   SD_SEND
> + #define SHUT_RDWR SD_BOTH
> +
> +#endif
> +
> +#define IOV_MAX 16
> +struct iovec {
> +  void *iov_base;
> +  size_t iov_len;
> +};
> +
> +struct msghdr {
> +  struct iovec *msg_iov;
> +  size_t msg_iovlen;
> +};
>  
>  class SimpleMessenger;
>  class IncomingQueue;
> diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
> index cf1e6c6..5d728c9 100644
> --- a/src/msg/SimpleMessenger.cc
> +++ b/src/msg/SimpleMessenger.cc
> @@ -40,7 +40,9 @@ static ostream& _prefix(std::ostream *_dout, SimpleMessenger *msgr) {
>  SimpleMessenger::SimpleMessenger(CephContext *cct, entity_name_t name,
>  				 string mname, uint64_t _nonce)
>    : Messenger(cct, name),
> +#if !defined(_WIN32)
>      accepter(this, _nonce),
> +#endif
>      dispatch_queue(cct, this),
>      reaper_thread(this),
>      my_type(name.type()),
> @@ -74,10 +76,12 @@ void SimpleMessenger::ready()
>    ldout(cct,10) << "ready " << get_myaddr() << dendl;
>    dispatch_queue.start();
>  
> +#if !defined(_WIN32)
>    lock.Lock();
>    if (did_bind)
>      accepter.start();
>    lock.Unlock();
> +#endif
>  }
>  
>  
> @@ -266,21 +270,30 @@ int SimpleMessenger::bind(const entity_addr_t &bind_addr)
>    ldout(cct,10) << "rank.bind " << bind_addr << dendl;
>    lock.Unlock();
>  
> +#if !defined(_WIN32)
>    // bind to a socket
>    set<int> avoid_ports;
>    int r = accepter.bind(bind_addr, avoid_ports);
>    if (r >= 0)
>      did_bind = true;
>    return r;
> +#else
> +  did_bind = false;
> +  return 0;
> +#endif
>  }
>  
>  int SimpleMessenger::rebind(const set<int>& avoid_ports)
>  {
> +#if !defined(_WIN32)
>    ldout(cct,1) << "rebind avoid " << avoid_ports << dendl;
>    assert(did_bind);
>    int r = accepter.rebind(avoid_ports);
>    mark_down_all();
>    return r;
> +#else
> +  return 0;
> +#endif
>  }
>  
>  int SimpleMessenger::start()
> @@ -304,6 +317,7 @@ int SimpleMessenger::start()
>    return 0;
>  }
>  
> +#if !defined(_WIN32)
>  Pipe *SimpleMessenger::add_accept_pipe(int sd)
>  {
>    lock.Lock();
> @@ -317,6 +331,7 @@ Pipe *SimpleMessenger::add_accept_pipe(int sd)
>    lock.Unlock();
>    return p;
>  }
> +#endif
>  
>  /* connect_rank
>   * NOTE: assumes messenger.lock held.
> @@ -511,12 +526,14 @@ void SimpleMessenger::wait()
>    ldout(cct,10) << "wait: dispatch queue is stopped" << dendl;
>    
>    // done!  clean up.
> +#if !defined(_WIN32)
>    if (did_bind) {
>      ldout(cct,20) << "wait: stopping accepter thread" << dendl;
>      accepter.stop();
>      did_bind = false;
>      ldout(cct,20) << "wait: stopped accepter thread" << dendl;
>    }
> +#endif
>  
>    if (reaper_started) {
>      ldout(cct,20) << "wait: stopping reaper thread" << dendl;
> diff --git a/src/msg/SimpleMessenger.h b/src/msg/SimpleMessenger.h
> index e6e1fb1..2b0e446 100644
> --- a/src/msg/SimpleMessenger.h
> +++ b/src/msg/SimpleMessenger.h
> @@ -200,9 +200,12 @@ private:
>     */
>  
>  public:
> +#if !defined(_WIN32)
>    Accepter accepter;
> +#endif
>    DispatchQueue dispatch_queue;
>  
> +#if !defined(_WIN32)
>    friend class Accepter;
>  
>    /**
> @@ -211,6 +214,7 @@ public:
>     * @param sd socket
>     */
>    Pipe *add_accept_pipe(int sd);
> +#endif
>  
>  private:
>  
> diff --git a/src/msg/msg_types.cc b/src/msg/msg_types.cc
> index b02db76..8284ea6 100644
> --- a/src/msg/msg_types.cc
> +++ b/src/msg/msg_types.cc
> @@ -1,10 +1,16 @@
>  
>  #include "msg_types.h"
>  
> -#include <arpa/inet.h>
> +#if !defined(_WIN32)
> + #include <arpa/inet.h>
> + #include <netdb.h>
> +#else
> + #include <winsock2.h>
> + #include <ws2tcpip.h>
> +#endif
> +
>  #include <stdlib.h>
>  #include <string.h>
> -#include <netdb.h>
>  
>  #include "common/Formatter.h"
>  
> @@ -46,6 +52,33 @@ void entity_addr_t::generate_test_instances(list<entity_addr_t*>& o)
>    o.push_back(b);
>  }
>  
> +#if defined(_WIN32)
> +/* windows doesn't have an inet_pton compatible function until Vista */
> +int inet_pton(int af, const char *src, void *dst) {
> +  
> +  switch(af) {
> +  case AF_INET:
> +  {
> +    struct in_addr *a4 = (struct in_addr *)dst;
> +    int o1, o2, o3, o4;
> +    char term;
> +    int scanned = sscanf(src, "%u.%u.%u.%u%c", &o1, &o2, &o3, &o4, &term);
> +    if (scanned != 4) {
> +      return 0;
> +    }
> +    if ((o1|o2|o3|o4) & 0xffffff00) {
> +      return 0;
> +    }
> +    a4->s_addr = htonl((o1 << 24) | (o2 << 16) | (o3 << 8) | (o4));
> +    return 1;
> +  }
> +  default:
> +    errno = EAFNOSUPPORT;
> +    return -1;
> +  }
> +}
> +#endif
> +
>  bool entity_addr_t::parse(const char *s, const char **end)
>  {
>    memset(this, 0, sizeof(*this));
> @@ -129,7 +162,8 @@ bool entity_addr_t::parse(const char *s, const char **end)
>    //cout << *this << std::endl;
>    return true;
>  }
> -
> +#if !defined(_WIN32)
> +#endif
>  
>  
>  ostream& operator<<(ostream& out, const sockaddr_storage &ss)
> diff --git a/src/msg/msg_types.h b/src/msg/msg_types.h
> index ee79ff7..e6e98e0 100644
> --- a/src/msg/msg_types.h
> +++ b/src/msg/msg_types.h
> @@ -15,7 +15,12 @@
>  #ifndef CEPH_MSG_TYPES_H
>  #define CEPH_MSG_TYPES_H
>  
> -#include <netinet/in.h>
> +#if defined(_WIN32)
> + #include <winsock2.h>
> + #include <ws2tcpip.h>
> +#else
> + #include <netinet/in.h>
> +#endif
>  
>  #include "include/types.h"
>  #include "include/blobhash.h"
> diff --git a/src/os/ObjectStore.h b/src/os/ObjectStore.h
> index 6494290..3f3830a 100644
> --- a/src/os/ObjectStore.h
> +++ b/src/os/ObjectStore.h
> @@ -27,7 +27,7 @@
>  
>  #if defined(DARWIN) || defined(__FreeBSD__)
>  #include <sys/statvfs.h>
> -#else
> +#elif !defined(_WIN32)
>  #include <sys/vfs.h>    /* or <sys/statfs.h> */
>  #endif /* DARWIN */
>  
> diff --git a/src/osd/PG.h b/src/osd/PG.h
> index d751916..3d42c07 100644
> --- a/src/osd/PG.h
> +++ b/src/osd/PG.h
> @@ -50,6 +50,7 @@
>  #include "include/str_list.h"
>  #include "PGBackend.h"
>  
> +#include "include/compat.h"
>  #include <list>
>  #include <memory>
>  #include <string>
> diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
> index e7cd231..61b741d 100644
> --- a/src/osd/osd_types.h
> +++ b/src/osd/osd_types.h
> @@ -1489,6 +1489,7 @@ inline ostream& operator<<(ostream& out, const pg_query_t& q) {
>   * pg_log_entry_t - single entry/event in pg log
>   *
>   */
> +#undef DELETE
>  struct pg_log_entry_t {
>    enum {
>      MODIFY = 1,
> diff --git a/src/osdc/ObjectCacher.h b/src/osdc/ObjectCacher.h
> index d7ba9d8..3247415 100644
> --- a/src/osdc/ObjectCacher.h
> +++ b/src/osdc/ObjectCacher.h
> @@ -7,6 +7,7 @@
>  #include "include/lru.h"
>  #include "include/Context.h"
>  #include "include/xlist.h"
> +#include "include/compat.h"
>  
>  #include "common/Cond.h"
>  #include "common/Finisher.h"
> diff --git a/src/osdc/Objecter.cc b/src/osdc/Objecter.cc
> index d2c574d..5a23126 100644
> --- a/src/osdc/Objecter.cc
> +++ b/src/osdc/Objecter.cc
> @@ -212,6 +212,7 @@ void Objecter::init_unlocked()
>    }
>  
>    m_request_state_hook = new RequestStateHook(this);
> +#if !defined(_WIN32)
>    AdminSocket* admin_socket = cct->get_admin_socket();
>    int ret = admin_socket->register_command("objecter_requests",
>  					   "objecter_requests",
> @@ -221,6 +222,7 @@ void Objecter::init_unlocked()
>      lderr(cct) << "error registering admin socket command: "
>  	       << cpp_strerror(-ret) << dendl;
>    }
> +#endif
>  }
>  
>  void Objecter::init_locked()
> @@ -256,8 +258,10 @@ void Objecter::shutdown_locked()
>  void Objecter::shutdown_unlocked()
>  {
>    if (m_request_state_hook) {
> +#if !defined(_WIN32)
>      AdminSocket* admin_socket = cct->get_admin_socket();
>      admin_socket->unregister_command("objecter_requests");
> +#endif
>      delete m_request_state_hook;
>      m_request_state_hook = NULL;
>    }
> diff --git a/src/rbd.cc b/src/rbd.cc
> index 082f9a9..a8d26bb 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -41,7 +41,9 @@
>  #include <sys/types.h>
>  #include <time.h>
>  #include "include/memory.h"
> +#if !defined(_WIN32)
>  #include <sys/ioctl.h>
> +#endif
>  
>  #include "include/rbd_types.h"
>  #include "common/TextTable.h"
> @@ -57,6 +59,10 @@
>  #include <sys/param.h>
>  #endif
>  
> +#if defined(_WIN32)
> +#include <winsock2.h>
> +#endif
> +
>  #define MAX_SECRET_LEN 1000
>  #define MAX_POOL_NAME_SIZE 128
>  
> @@ -967,6 +973,7 @@ static int export_read_cb(uint64_t ofs, size_t len, const char *buf, void *arg)
>    static char *localbuf = NULL;
>    static size_t maplen = 0;
>  
> +#if !defined(_WIN32)
>    if (fd == 1) {
>      if (!buf) {
>        // can't seek stdout; need actual data to write
> @@ -994,6 +1001,7 @@ static int export_read_cb(uint64_t ofs, size_t len, const char *buf, void *arg)
>        ret = write(fd, buf, len);
>      }
>    } else {		// not stdout
> +#endif
>      if (!buf || buf_is_zero(buf, len)) {
>        /* a hole */
>        return 0;
> @@ -1004,7 +1012,9 @@ static int export_read_cb(uint64_t ofs, size_t len, const char *buf, void *arg)
>        return -errno;
>      ret = write(fd, buf, len);
>      ec->pc.update_progress(ofs, ec->totalsize);
> +#if !defined(_WIN32)
>    }
> +#endif
>  
>    if (ret < 0)
>      return -errno;
> @@ -1265,6 +1275,7 @@ done_img:
>    update_snap_name(*new_img, snap);
>  }
>  
> +#if !defined(_WIN32)
>  static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
>  		     const char *imgname, int *order, const char *path,
>  		     int format, uint64_t features, uint64_t size)
> @@ -1313,14 +1324,18 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
>        size = (uint64_t)stat_buf.st_size;
>  
>      if (!size) {
> +#if !defined(_WIN32)
>        int64_t bdev_size = 0;
>        r = get_block_device_size(fd, &bdev_size);
>        if (r < 0) {
> +#endif
>  	cerr << "rbd: unable to get size of file/block device" << std::endl;
>  	goto done;
> +#if !defined(_WIN32)
>        }
>        assert(bdev_size >= 0);
>        size = (uint64_t) bdev_size;
> +#endif
>      }
>    }
>    r = do_create(rbd, io_ctx, imgname, size, order, format, features, 0, 0);
> @@ -1397,6 +1412,7 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
>    delete[] p;
>    return r;
>  }
> +#endif
>  
>  static int read_string(int fd, unsigned max, string *out)
>  {
> @@ -1626,6 +1642,7 @@ static int do_watch(librados::IoCtx& pp, const char *imgname)
>    return 0;
>  }
>  
> +#if !defined(_WIN32)
>  static int do_kernel_add(const char *poolname, const char *imgname,
>  			 const char *snapname)
>  {
> @@ -1733,6 +1750,7 @@ static int do_kernel_add(const char *poolname, const char *imgname,
>  
>    return r;
>  }
> +#endif
>  
>  static int read_file(const char *filename, char *buf, size_t bufsize)
>  {
> @@ -1909,6 +1927,7 @@ static int get_rbd_seq(int major_num, string &seq)
>    return -ENOENT;
>  }
>  
> +#if !defined(_WIN32)
>  static int do_kernel_rm(const char *dev)
>  {
>    struct stat dev_stat;
> @@ -1971,6 +1990,7 @@ static int do_kernel_rm(const char *dev)
>      r = -errno;
>    return r;
>  }
> +#endif
>  
>  enum {
>    OPT_NO_CMD = 0,
> @@ -2114,6 +2134,11 @@ int main(int argc, const char **argv)
>    librados::IoCtx io_ctx, dest_io_ctx;
>    librbd::Image image;
>  
> +  #if defined(_WIN32)
> +  /* make sure files are opened in binary mode otherwise they get dos linefeeds */
> +  _fmode = _O_BINARY;
> +  #endif
> +
>    vector<const char*> args;
>  
>    argv_to_vec(argc, argv, args);
> @@ -2232,6 +2257,9 @@ int main(int argc, const char **argv)
>      }
>    }
>  
> +  WSADATA wsadata;
> +  WSAStartup(MAKEWORD(2, 0), &wsadata);
> +
>    common_init_finish(g_ceph_context);
>  
>    i = args.begin();
> @@ -2772,6 +2800,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>      }
>      break;
>  
> +//#if !defined(_WIN32)
>    case OPT_EXPORT:
>      if (!path) {
>        cerr << "rbd: export requires pathname" << std::endl;
> @@ -2804,6 +2833,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>      }
>      break;
>  
> +#if !defined(_WIN32)
>    case OPT_IMPORT:
>      if (!path) {
>        cerr << "rbd: import requires pathname" << std::endl;
> @@ -2825,6 +2855,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>        return -r;
>      }
>      break;
> +#endif
>  
>    case OPT_COPY:
>      r = do_copy(image, dest_io_ctx, destname);
> @@ -2842,6 +2873,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>      }
>      break;
>  
> +#if !defined(_WIN32)
>    case OPT_MAP:
>      r = do_kernel_add(poolname, imgname, snapname);
>      if (r < 0) {
> @@ -2857,6 +2889,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>        return -r;
>      }
>      break;
> +#endif
>  
>    case OPT_SHOWMAPPED:
>      r = do_kernel_showmapped(formatter.get());
> diff --git a/win32/INSTALL b/win32/INSTALL
> new file mode 100644
> index 0000000..8b04fac
> --- /dev/null
> +++ b/win32/INSTALL
> @@ -0,0 +1,16 @@
> +Debian includes a lot of the required software in the mingw packages.
> +
> +Additional software required. All seems to build and install without issue:
> +. boost
> +. cryptopp
> +. libatomic-ops
> +
> +boost - tested with 1.49. newer is known to not work
> +. download and extract
> +. ./bootstrap.sh --with-python=$(which python2) --prefix=/usr/x86_64-w64-mingw32/ --without-icu --with-libraries=system,thread
> +. change toolset in project-config.jam to "using gcc : : x86_64-w64-mingw32-g++ ;" (space before ; is important)
> +. link libpthreadGC2.a to the actual pthread lib
> +. PTW32_INCLUDE=/usr/x86_64-w64-mingw32/include PTW32_LIB=/usr/x86_64-w64-mingw32/lib ./bjam --layout=system variant=release threading=multi link=shared runtime-link=shared toolset=gcc target-os=windows install 
> +
> +cryptopp
> +. CXX=/usr/bin/x86_64-w64-mingw32-g++ AR=/usr/bin/x86_64-w64-mingw32-ar RANLIB=/usr/bin/x86_64-w64-mingw32-ranlib make
> diff --git a/win32/Makefile b/win32/Makefile
> new file mode 100644
> index 0000000..9b965a8
> --- /dev/null
> +++ b/win32/Makefile
> @@ -0,0 +1,249 @@
> +CC=/usr/bin/x86_64-w64-mingw32-gcc
> +CXX=/usr/bin/x86_64-w64-mingw32-g++
> +AR=/usr/bin/x86_64-w64-mingw32-ar
> +STRIP=/usr/bin/x86_64-w64-mingw32-strip
> +CFLAGS = -D_POSIX -DCEPH_LIBDIR=""
> +
> +DIRS = \
> +	arch \
> +	auth \
> +	auth/cephx \
> +	auth/unknown \
> +	auth/none \
> +	common \
> +	perfglue \
> +	crush \
> +	json_spirit \
> +	log \
> +	mon \
> +	os \
> +	msg \
> +	osd \
> +	mds \
> +	librbd \
> +	cls \
> +	cls/rbd \
> +	cls/lock \
> +	osdc \
> +	librados \
> +	global
> +
> +LIBCOMMON_SRC = \
> +	winmain.c \
> +	arch/intel.cc \
> +	arch/neon.c \
> +	arch/probe.c \
> +	auth/AuthClientHandler.cc \
> +	auth/AuthMethodList.cc \
> +	auth/AuthSessionHandler.cc \
> +	auth/Crypto.cc \
> +	auth/KeyRing.cc \
> +	auth/RotatingKeyRing.cc \
> +	auth/cephx/CephxClientHandler.cc \
> +	auth/cephx/CephxProtocol.cc \
> +	auth/cephx/CephxSessionHandler.cc \
> +	common/BackTrace.cc \
> +	common/Clock.cc \
> +	common/ConfUtils.cc \
> +	common/DecayCounter.cc \
> +	common/Finisher.cc \
> +	common/Formatter.cc \
> +	common/HeartbeatMap.cc \
> +	common/LogClient.cc \
> +	common/LogEntry.cc \
> +	common/Mutex.cc \
> +	common/PrebufferedStreambuf.cc \
> +	common/RefCountedObj.cc \
> +	common/Thread.cc \
> +	common/Throttle.cc \
> +	common/Timer.cc \
> +	common/addr_parsing.c \
> +	common/armor.c \
> +	common/assert.cc \
> +	common/buffer.cc \
> +	common/ceph_argparse.cc \
> +	common/ceph_context.cc \
> +	common/ceph_crypto.cc \
> +	common/ceph_hash.cc \
> +	common/ceph_strings.cc \
> +	common/cmdparse.cc \
> +	common/code_environment.cc \
> +	common/common_init.cc \
> +	common/config.cc \
> +	common/crc32c.cc \
> +	common/crc32c_intel_baseline.c \
> +	common/crc32c_intel_fast.c \
> +	common/dout.cc \
> +	common/entity_name.cc \
> +	common/environment.cc \
> +	common/errno.cc \
> +	common/escape.c \
> +	common/hex.cc \
> +	common/hobject.cc \
> +	common/lockdep.cc \
> +	common/page.cc \
> +	common/perf_counters.cc \
> +	common/safe_io.c \
> +	common/sctp_crc32.c \
> +	common/snap_types.cc \
> +	common/str_list.cc \
> +	common/strtol.cc \
> +	common/utf8.c \
> +	common/version.cc \
> +	crush/CrushWrapper.cc \
> +	crush/builder.c \
> +	crush/crush.c \
> +	crush/hash.c \
> +	crush/mapper.c \
> +	json_spirit/json_spirit_reader.cpp \
> +	log/Log.cc \
> +	log/SubsystemMap.cc \
> +	mds/MDSMap.cc \
> +	mds/inode_backtrace.cc \
> +	mds/mdstypes.cc \
> +	mon/MonCap.cc \
> +	mon/MonClient.cc \
> +	mon/MonMap.cc \
> +	msg/DispatchQueue.cc \
> +	msg/Message.cc \
> +	msg/SimpleMessenger.cc \
> +	msg/msg_types.cc \
> +	osd/OSDMap.cc \
> +	osd/osd_types.cc \
> +	msg/Pipe.cc
> +
> +unusedLIBCOMMON_SRC = \
> +	msg/Accepter.cc \
> +	common/fd.cc \
> +	common/admin_socket.cc \
> +	ceph_ver.c auth/AuthAuthorizeHandler.cc \
> +	auth/cephx/CephxAuthorizeHandler.cc \
> +	auth/none/AuthNoneAuthorizeHandler.cc \
> +	auth/unknown/AuthUnknownAuthorizeHandler.cc \
> +	common/BackTrace.cc \
> +	common/run_cmd.cc common/WorkQueue.cc \
> +	common/MemoryModel.cc \
> +	common/xattr.c \
> +	msg/Messenger.cc \
> +	common/blkdev.cc \
> +	common/pipe.c \
> +	common/signal.cc \
> +	common/simple_spin.cc \
> +	include/ceph_fs.cc \
> +	include/ceph_frag.cc \
> +	common/mime.c \
> +	common/ceph_crypto_cms.cc \
> +	common/ceph_json.cc \
> +	common/ipaddr.cc \
> +	common/pick_address.cc \
> +	json_spirit/json_spirit_writer.cpp \
> +	json_spirit/json_spirit_value.cpp \
> +	perfglue/disabled_stubs.cc \
> +	common/admin_socket_client.cc \
> +	perfglue/cpu_profiler.cc \
> +	common/OutputDataSocket.cc \
> +	crush/CrushCompiler.cc \
> +	crush/CrushTester.cc
> +LIBCOMMON_OBJS = $(subst .c,.o,$(subst .cc,.o,$(subst .cpp,.o,$(LIBCOMMON_SRC))))
> +LIBCOMMON_LIB = libcommon.a
> +
> +LIBGLOBAL_SRC = \
> +	global/global_context.cc \
> +	global/global_init.cc \
> +	global/pidfile.cc
> +unusedLIBGLOBAL_SRC = \
> +	global/signal_handler.cc
> +LIBGLOBAL_OBJS = $(subst .c,.o,$(subst .cc,.o,$(subst .cpp,.o,$(LIBGLOBAL_SRC))))
> +LIBGLOBAL_LIB = libglobal.a
> +
> +LIBRADOS_SRC = \
> +	librados/IoCtxImpl.cc \
> +	librados/RadosClient.cc \
> +	librados/librados.cc \
> +	librados/snap_set_diff.cc \
> +	osdc/Objecter.cc \
> +	osdc/Striper.cc \
> +	cls/lock/cls_lock_client.cc \
> +	cls/lock/cls_lock_types.cc \
> +	cls/lock/cls_lock_ops.cc
> +LIBRADOS_OBJS = $(subst .c,.o,$(subst .cc,.o,$(subst .cpp,.o,$(LIBRADOS_SRC))))
> +LIBRADOS_DLL = librados.dll
> +LIBRADOS_LIB = librados.a
> +
> +LIBRBD_SRC = \
> +	cls/lock/cls_lock_client.cc \
> +	cls/lock/cls_lock_types.cc \
> +	cls/lock/cls_lock_ops.cc \
> +	cls/rbd/cls_rbd_client.cc \
> +	common/util.cc \
> +	librbd/librbd.cc \
> +	librbd/AioCompletion.cc \
> +	librbd/AioRequest.cc \
> +	librbd/ImageCtx.cc \
> +	librbd/internal.cc \
> +	librbd/LibrbdWriteback.cc \
> +	librbd/WatchCtx.cc \
> +	librados/snap_set_diff.cc \
> +	osdc/ObjectCacher.cc \
> +	osdc/Striper.cc
> +LIBRBD_OBJS = $(subst .c,.o,$(subst .cc,.o,$(subst .cpp,.o,$(LIBRBD_SRC))))
> +LIBRBD_DLL = librbd.dll
> +LIBRBD_LIB = librbd.a
> +
> +RBD_SRC = rbd.cc common/TextTable.cc common/util.cc
> +#RBD_SRC = rbd.cc common/secret.c common/TextTable.cc common/util.cc
> +RBD_OBJS = $(subst .c,.o,$(subst .cc,.o,$(subst .cpp,.o,$(RBD_SRC))))
> +RBD_EXE = rbd.exe
> +
> +INCLUDES = \
> +	-Iinclude \
> +	-I../src
> +	#-I../src/include
> +LIBS = -lpthread -lcryptopp -lws2_32 -lboost_thread.dll -lboost_system.dll
> +
> +vpath %.c ../src/
> +vpath %.cc ../src/
> +vpath %.cpp ../src/
> +
> +all: $(DIRS) $(LIBCOMMON_LIB) $(LIBGLOBAL_LIB) $(LIBRADOS_DLL) $(LIBRBD_DLL) $(RBD_EXE)
> +
> +distclean: clean
> +
> +clean:
> +	find . -name '*.o' -type f -print0 | xargs -0 rm -f
> +	find . -name '*.a' -type f -print0 | xargs -0 rm -f
> +	find . -name '*.lib' -type f -print0 | xargs -0 rm -f
> +	find . -name '*.dll' -type f -print0 | xargs -0 rm -f
> +	find . -name '*.exe' -type f -print0 | xargs -0 rm -f
> +
> +%.o: %.c
> +	$(CC) $(INCLUDES) $(CFLAGS) -c $< -o $@
> +
> +%.o: %.cc
> +	$(CXX) $(INCLUDES) $(CFLAGS) -c $< -o $@
> +
> +%.o: %.cpp
> +	$(CXX) $(INCLUDES) $(CFLAGS) -c $< -o $@
> +
> +.PHONY: $(DIRS)
> +$(DIRS):
> +	mkdir -p $@
> +
> +$(LIBCOMMON_LIB): $(LIBCOMMON_OBJS)
> +	$(AR) rcs $@ $^
> +
> +$(LIBGLOBAL_LIB): $(LIBGLOBAL_OBJS)
> +	$(AR) rcs $@ $^
> +
> +$(LIBRADOS_DLL): $(LIBRADOS_OBJS) $(LIBCOMMON_LIB)
> +	$(CXX) -shared -o $@ $(LIBRADOS_OBJS) -L. -lcommon $(LIBS)
> +	$(STRIP) $@
> +
> +$(LIBRBD_DLL): $(LIBRBD_OBJS) $(LIBCOMMON_LIB)
> +	$(CXX) -shared -o $@ $(LIBRBD_OBJS) -L. -lrados -lcommon $(LIBS)
> +	$(STRIP) $@
> +
> +$(RBD_EXE): $(RBD_OBJS) $(LIBCOMMON_LIB) $(LIBGLOBAL_LIB)
> +	$(CXX) -o $@ $(RBD_OBJS) -L. -lglobal -lrbd -lrados -lcommon $(LIBS)
> +	$(STRIP) $@
> +
> diff --git a/win32/include/acconfig.h b/win32/include/acconfig.h
> new file mode 100644
> index 0000000..cf40bd4
> --- /dev/null
> +++ b/win32/include/acconfig.h
> @@ -0,0 +1,6 @@
> +#define USE_CRYPTOPP
> +#define HAVE_INTTYPES_H
> +/* Windows is always little endian */
> +#define LITTLE_ENDIAN 1234
> +#define BIG_ENDIAN 4321
> +#define BYTE_ORDER LITTLE_ENDIAN
> diff --git a/win32/winmain.c b/win32/winmain.c
> new file mode 100644
> index 0000000..a5efdb6
> --- /dev/null
> +++ b/win32/winmain.c
> @@ -0,0 +1,2 @@
> +int WinMain() {
> +}
> 
> 
