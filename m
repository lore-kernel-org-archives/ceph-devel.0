From: yuxiang fang <abcdeffyx@gmail.com>
Subject: Re: radosgw hang in curl_muti_wait with libcurl 7.37.0
Date: Fri, 4 Aug 2017 01:45:55 +0800
Message-ID: <CAOi4hNfhAeSGKahgwRBb4yxzU8S5Lije+Y1K8H4bEukoJS3cQw@mail.gmail.com>
References: <CAOi4hNdgNoGDMq56A24UPr4v7HMCw93Jd4ico1xwbCoR8333dA@mail.gmail.com>
 <169935fe-8bca-56f0-ed89-9fa1e61c7c2a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38737 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdHCRq0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Aug 2017 13:46:26 -0400
Received: by mail-pg0-f48.google.com with SMTP id l64so8894899pge.5
        for <ceph-devel@vger.kernel.org>; Thu, 03 Aug 2017 10:46:26 -0700 (PDT)
In-Reply-To: <169935fe-8bca-56f0-ed89-9fa1e61c7c2a@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Casey,

updates:
Issue reproduced with another situation today:
RGWDataSyncShardCR is blocked by RGWReadRemoteDataLogShardInfoCR, lead
to data sync incomplete. Using gdb, and I found the http_op of it is
left in the related RGWHTTPManager's reqs queue, whose
reqs_thread_entry can't complete that req. event I shutdown the
net-link of the remote IP.

Have you been able to correlate this hang with the radosgw on the receiving end?
A: Almost occur in the HTTP sender side, I have seen three kinds of
request blocked by libcurl, datalog-list, data-log-change-notify and
fetch-remote-obj.

Are you sure it's getting this request and sending a reply?
A: I am not sure.

Does this happen on every sync request, or just some?
A: Just some, occasionally. But I think this may happen on all kinds
of HTTP request

thanks
ivan from eisoo


On Thu, Aug 3, 2017 at 10:05 PM, Casey Bodley <cbodley@redhat.com> wrote:
> Hi,
>
> Have you been able to correlate this hang with the radosgw on the receiving
> end? Are you sure it's getting this request and sending a reply? Does this
> happen on every sync request, or just some?
>
> Thanks,
> Casey
>
>
>
> On 08/02/2017 11:50 PM, yuxiang fang wrote:
>>
>> Resend mail for denied by the email server.
>>
>> For the sake of radosgw hang in curl_multi_wait, my team has upgraded
>> libcurl from 7.29.0 to 7.37.0, but this issue still appeared.
>> Is this definitely a bug of libcurl? and is there something wrong with
>> radosgw internal? I'm lost. Don't know which version of libcurl to
>> select. We ever tried
>> curl 7.54.0, but it is not stable, crashed usually.
>>
>> back trace:
>>
>> Thread 54 (Thread 0x7f32826fb700 (LWP 43459)):
>> #0  0x00007f32f3c54c3d in poll () from /lib64/libc.so.6
>> #1  0x00007f32f4caf039 in Curl_poll () from /lib64/libcurl.so.4
>> #2  0x00007f32f4ca7f04 in curl_multi_wait () from /lib64/libcurl.so.4
>> #3  0x00007f32f529753d in do_curl_wait(CephContext*, void*, int) ()
>> from /lib64/librgw.so.2
>> #4  0x00007f32f52999d9 in RGWHTTPManager::process_requests(bool,
>> bool*) () from /lib64/librgw.so.2
>> #5  0x00007f32f5299ec4 in RGWHTTPManager::complete_requests() () from
>> /lib64/librgw.so.2
>> #6  0x00007f32f5416ac4
>> inRGWRESTStreamRWRequest::get_resource(RGWAccessKey&,
>> std::map<std::string, std::string, std::less<std::string>,
>> std::allocator<std::pair<std::string const, std::string> > >&,
>> std::string const&, RGWHTTPManager*) () from /lib64/librgw.so.2
>> #7  0x00007f32f5416d2a in
>> RGWRESTStreamRWRequest::get_obj(RGWAccessKey&, std::map<std::string,
>> std::string, std::less<std::string>,
>> std::allocator<std::pair<std::string const, std::string> > >&,
>> rgw_obj&) () from /lib64/librgw.so.2
>> #8  0x00007f32f541c0fc in RGWRESTConn::get_obj(rgw_user
>> const&,req_info*, rgw_obj&,
>> std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
>> const*, std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
>> const*, unsigned int, unsigned long, bool, bool, bool, bool,
>> RGWGetDataCB*, RGWRESTStreamRWRequest**) () from /lib64/librgw.so.2
>> #9  0x00007f32f53d88d7 in RGWRados::fetch_remote_obj(RGWObjectCtx&,
>> rgw_user const&, std::string const&, std::string const&, bool,
>> req_info*, std::string const&, rgw_obj&, rgw_obj&, RGWBucketInfo&,
>> RGWBucketInfo&, std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*,
>> std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*,
>> std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
>> const*, std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >
>> const*, bool, char const*, char const*, RGWRados::AttrsMod, bool,
>> std::map<std::string, ceph::buffer::list, std::less<std::string>,
>> std::allocator<std::pair<std::string const, ceph::buffer::list> > >&,
>> RGWObjCategory, unsigned long,
>> std::chrono::time_point<ceph::time_detail::real_clock,
>> std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >,
>> std::string*, std::string*, ceph::buffer::list*, rgw_err*, void
>> (*)(long, void*), void*) () from /lib64/librgw.so.2
>> #10 0x00007f32f5249b43 in RGWAsyncFetchRemoteObj::_send_request() ()
>> from /lib64/librgw.so.2
>> #11 0x00007f32f5246d52 in
>> RGWAsyncRadosProcessor::handle_request(RGWAsyncRadosRequest*) () from
>> /lib64/librgw.so.2
>> #12 0x00007f32f5246e1d in
>> RGWAsyncRadosProcessor::RGWWQ::_process(RGWAsyncRadosRequest*,
>> ThreadPool::TPHandle&) () from /lib64/librgw.so.2
>> #13 0x00007f32f57283be in ThreadPool::worker(ThreadPool::WorkThread*)
>> () from /lib64/librgw.so.2
>> #14 0x00007f32f57292a0 in ThreadPool::WorkThread::entry() () from
>> /lib64/librgw.so.2
>> #15 0x00007f32f485bdc5 in start_thread () from /lib64/libpthread.so.0
>> #16 0x00007f32f3c5f28d in clone () from /lib64/libc.so.6
>>
>> thanks
>> ivan from eisoo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
