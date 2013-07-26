From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Re: question about striped_read
Date: Fri, 26 Jul 2013 09:14:43 +0800
Message-ID: <CAAM7YAm0VnhuYanC+gj7M==snc4XDvPd5q0qCK=DchvqPCcmDw@mail.gmail.com>
References: <201307250852310158703@gmail.com>
	<alpine.DEB.2.00.1307242252080.10870@cobra.newdream.net>
	<201307251455102701172@gmail.com>
	<CAAM7YAnDKvGBsXxzbcsFHTbTo7-7AgNnRXRCK+gEbvkwGuj5cg@mail.gmail.com>
	<alpine.DEB.2.00.1307250848160.29435@cobra.newdream.net>
	<201307260848241340451@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:60018 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab3GZBOp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 21:14:45 -0400
Received: by mail-la0-f44.google.com with SMTP id fo12so767532lab.3
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 18:14:43 -0700 (PDT)
In-Reply-To: <201307260848241340451@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: majianpeng <majianpeng@gmail.com>
Cc: sage <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 26, 2013 at 8:48 AM, majianpeng <majianpeng@gmail.com> wrote:
>>On Thu, 25 Jul 2013, Yan, Zheng wrote:
>>> On Thu, Jul 25, 2013 at 2:55 PM, majianpeng <majianpeng@gmail.com> wrote:
>>> >>On Thu, 25 Jul 2013, majianpeng wrote:
>>> >>> Hi all,
>>> >>>      I met a problem and ask somebody could help me.
>>> >>> In func striped_read()
>>> >>> > if (ret > 0) {
>>> >>> >                int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;
>>> >>>
>>> >>> >                if (read < pos - off) {
>>> >>> >                       dout(" zero gap %llu to %llu\n", off + read, pos);
>>> >>> >                        ceph_zero_page_vector_range(page_align + read,
>>> >>> >                                                    pos - off - read, pages);
>>> >>> >                }
>>> >>> >                pos += ret;
>>>
>>> I think you are right. probably above line should be 'pos += this_len'
>>
>>It should be easy to construct a simple test for this.  E.g., something
>>like
>>
>> pwrite(fd, buf, 0, 3000000);
>> pwrite(fd, buf, 4194304, 1000);
>> pread(fd, buf, 0, 6000000);
>> ...
>>
>>and whatever else to verify that pos was in fact advanced properly?
>>
> The following is my test code:
> void hole_test()
> {
>         char buf[4194304];
>         ssize_t ret;
>         int fd = open("/media/ceph/test", O_RDWR|O_CREAT|O_DIRECT|O_TRUNC);
>         if (fd < 0) {
>                 printf("open error %s\n", strerror(errno));
>                 return;
>         }
>
>         ret = pwrite(fd, buf, 0, 3000000);
>         ret = pwrite(fd, buf, 4194304, 1000);
>         ret = pread(fd, buf , 0, 6000000);
>         close(fd);
> }
>
> The debug message from striped_read are:
> [  267.530266] ceph:           file.c:356  : striped_read 6000000~0 (read 0) got 0
> [  267.530270] ceph:           file.c:396  : striped_read returns 0
>
> The result isn't what's your said.
> Am i missing something?
>
> BTW, i think Yan is ok,
> The code
> pos += ret; should pos += this_len.
> Because this_len can larger than ret.
> But the question is what's condition can cause this?

by default, ceph strips file to 4M objects. In above example, the
first object only has
3M data, so 'ret = 3M'  and 'this_len = 4M'

> And can the short_read operation handle this situation?

I don't think it's good idea to short read unless we really reach EOF.

Regards
Yan, Zheng
