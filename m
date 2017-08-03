From: yuxiang fang <abcdeffyx@gmail.com>
Subject: radosgw hang in curl_muti_wait with libcurl 7.37.0
Date: Thu, 3 Aug 2017 11:50:04 +0800
Message-ID: <CAOi4hNdgNoGDMq56A24UPr4v7HMCw93Jd4ico1xwbCoR8333dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38795 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdHCDue (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 23:50:34 -0400
Received: by mail-pg0-f42.google.com with SMTP id l64so1169883pge.5
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 20:50:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Resend mail for denied by the email server.

For the sake of radosgw hang in curl_multi_wait, my team has upgraded
libcurl from 7.29.0 to 7.37.0, but this issue still appeared.
Is this definitely a bug of libcurl? and is there something wrong with
radosgw internal? I'm lost. Don't know which version of libcurl to
select. We ever tried
curl 7.54.0, but it is not stable, crashed usually.

back trace:

Thread 54 (Thread 0x7f32826fb700 (LWP 43459)):
#0  0x00007f32f3c54c3d in poll () from /lib64/libc.so.6
#1  0x00007f32f4caf039 in Curl_poll () from /lib64/libcurl.so.4
#2  0x00007f32f4ca7f04 in curl_multi_wait () from /lib64/libcurl.so.4
#3  0x00007f32f529753d in do_curl_wait(CephContext*, void*, int) ()
from /lib64/librgw.so.2
#4  0x00007f32f52999d9 in RGWHTTPManager::process_requests(bool,
bool*) () from /lib64/librgw.so.2
#5  0x00007f32f5299ec4 in RGWHTTPManager::complete_requests() () from
/lib64/librgw.so.2
#6  0x00007f32f5416ac4 inRGWRESTStreamRWRequest::get_resource(RGWAccessKey&,
std::map<std::string, std::string, std::less<std::string>,
std::allocator<std::pair<std::string const, std::string> > >&,
std::string const&, RGWHTTPManager*) () from /lib64/librgw.so.2
#7  0x00007f32f5416d2a in
RGWRESTStreamRWRequest::get_obj(RGWAccessKey&, std::map<std::string,
std::string, std::less<std::string>,
std::allocator<std::pair<std::string const, std::string> > >&,
rgw_obj&) () from /lib64/librgw.so.2
#8  0x00007f32f541c0fc in RGWRESTConn::get_obj(rgw_user
const&,req_info*, rgw_obj&,
std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
const*, std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
const*, unsigned int, unsigned long, bool, bool, bool, bool,
RGWGetDataCB*, RGWRESTStreamRWRequest**) () from /lib64/librgw.so.2
#9  0x00007f32f53d88d7 in RGWRados::fetch_remote_obj(RGWObjectCtx&,
rgw_user const&, std::string const&, std::string const&, bool,
req_info*, std::string const&, rgw_obj&, rgw_obj&, RGWBucketInfo&,
RGWBucketInfo&, std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*,
std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*,
std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
const*, std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
const*, bool, char const*, char const*, RGWRados::AttrsMod, bool,
std::map<std::string, ceph::buffer::list, std::less<std::string>,
std::allocator<std::pair<std::string const, ceph::buffer::list> > >&,
RGWObjCategory, unsigned long,
std::chrono::time_point<ceph::time_detail::real_clock,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >,
std::string*, std::string*, ceph::buffer::list*, rgw_err*, void
(*)(long, void*), void*) () from /lib64/librgw.so.2
#10 0x00007f32f5249b43 in RGWAsyncFetchRemoteObj::_send_request() ()
from /lib64/librgw.so.2
#11 0x00007f32f5246d52 in
RGWAsyncRadosProcessor::handle_request(RGWAsyncRadosRequest*) () from
/lib64/librgw.so.2
#12 0x00007f32f5246e1d in
RGWAsyncRadosProcessor::RGWWQ::_process(RGWAsyncRadosRequest*,
ThreadPool::TPHandle&) () from /lib64/librgw.so.2
#13 0x00007f32f57283be in ThreadPool::worker(ThreadPool::WorkThread*)
() from /lib64/librgw.so.2
#14 0x00007f32f57292a0 in ThreadPool::WorkThread::entry() () from
/lib64/librgw.so.2
#15 0x00007f32f485bdc5 in start_thread () from /lib64/libpthread.so.0
#16 0x00007f32f3c5f28d in clone () from /lib64/libc.so.6

thanks
ivan from eisoo
