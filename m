From: Haomai Wang <haomai@xsky.com>
Subject: Re: filestore_fiemap is bad, memstore is buggy.
Date: Sat, 17 Sep 2016 21:05:07 +0800
Message-ID: <CACJqLyaUgWS3-LxtTgN+c+OwUzjE=Vt0ayhCFwVa_PUReX372g@mail.gmail.com>
References: <alpine.DEB.2.11.1609152142570.19761@piezo.us.to>
 <CACJqLyZPOJ8R-4=hZxPMZMzZj2WEGDdqrMNbuxHUsLjwVN6wMA@mail.gmail.com>
 <alpine.DEB.2.11.1609161323470.1037@piezo.us.to> <CACJqLyb31LmurPPpmi9_LbwvRGZaSp2sXmqpaFE5UXP3ynE4Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0113.outbound.protection.outlook.com ([104.47.124.113]:60904
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757396AbcIQNFZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 17 Sep 2016 09:05:25 -0400
Received: by mail-vk0-f48.google.com with SMTP id b133so62192545vka.2
        for <ceph-devel@vger.kernel.org>; Sat, 17 Sep 2016 06:05:19 -0700 (PDT)
In-Reply-To: <CACJqLyb31LmurPPpmi9_LbwvRGZaSp2sXmqpaFE5UXP3ynE4Ow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

*splice* feature is buggy in any case(disable fiemap/seek_data, enable
fiemap, enable seek_data). I'd like to disable it by default until we
have a clear answer to test failure. In other hand, from my previous
perf tests, splice doesn't show up outstanding improvements in ceph
usages(I think it's natural since splice only eliminate memory copy,
compared to ceph context, it's really not problem).

https://github.com/ceph/ceph/pull/11113

On Sat, Sep 17, 2016 at 12:29 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Fri, Sep 16, 2016 at 9:24 PM, Sage Weil <sweil@redhat.com> wrote:
>> On Fri, 16 Sep 2016, Haomai Wang wrote:
>>> On Fri, Sep 16, 2016 at 5:48 AM, Sage Weil <sweil@redhat.com> wrote:
>>> > I was adding tests for clone_range in preparation for improving the
>>> > bluestore implementation and got stuck on memstore and filestore bugs!
>>> >
>>> > The most alarming is that filestore very quickly fails the tests if
>>> > filestore_fiemap is enabled.  It's off by default (phew!) but the
>>> > ceph_test_objectstore test was explicitly enabling it to get better
>>> > coverage.  For now I've just removed that so we stick with the default (no
>>> > fiemap == good).  I wonder if we should consider removing fiemap from the
>>> > code entirely, though, since it is clearly buggy, even on a modern kernel
>>> > (I'm running 4.4 and XFS).
>>>
>>> I tried with the new test case, I found even disable fiemap, I will
>>> ran into failure. So I suspect the splice codes, I disable it, test
>>> passed.
>>>
>>> But fiemap and seek_data/seek_hole is still failing even disable
>>> splice, I would like to dive into more to verify our codes if correct
>>> since _do_seek_hole_data is copied from fiemap....
>>
>> Yeah, good idea.  Thanks for looking into it!
>
> Oh, I think I found the problem.
>
> If source file exists hole in [offset, length], fiemap or
> seek_data/seek_hole will return empty data map(map<uint64_t, uint64_t>
> exomap). So we won't write any to target file. But we exactly need to
> write zero to target file in [offset, length]....
>
> And the other case is we may write garbage data to target file. This
> fix may help a lot to cases:
>
> --- a/src/os/filestore/FileStore.cc
> +++ b/src/os/filestore/FileStore.cc
> @@ -3597,7 +3597,7 @@ int FileStore::_do_copy_range(int from, int to,
> uint64_t srcoff, u
>    int buflen = 4096 * 16; //limit by pipe max size.see fcntl
>
>  #ifdef CEPH_HAVE_SPLICE
> -  if (backend->has_splice()) {
> +  if (backend->has_splice() && 0) {
>      int pipefd[2];
>      if (pipe(pipefd) < 0) {
>        r = -errno;
> @@ -3661,6 +3661,7 @@ int FileStore::_do_copy_range(int from, int to,
> uint64_t srcoff, u
>      char buf[buflen];
>      while (pos < end) {
>        int l = MIN(end-pos, buflen);
> +      memset(buf, 0, l);
>        r = ::read(from, buf, l);
>        dout(25) << "  read from " << pos << "~" << l << " got " << r << dendl;
>        if (r < 0) {
>
> Hmm, I'm on the vacation and don't have test machine at hand. Let me
> rethink this logic and verify it's true. Anyone who want to fix this
> problem immediately, plz feel free to do... Or correct me if I'm
> wrong!
>
>>
>> sage
