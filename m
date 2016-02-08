From: kefu chai <tchaikov@gmail.com>
Subject: Re: FreeBSD crushtool crashing while checking a crushmap
Date: Mon, 8 Feb 2016 13:53:53 +0800
Message-ID: <CAJE9aONwRb7pfG=K+GdJ1mg8ePd9FQ0iy-fnwWcF7qQ5jarbbQ@mail.gmail.com>
References: <56B66FC0.70409@digiware.nl>
	<CAJE9aOOj3kak2p90RUcD8ps+M_j05NwA-KfYGxZyb3-u1zHkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11421f006a74b9052b3bd3bf
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35559 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcBHFxy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 00:53:54 -0500
Received: by mail-yw0-f182.google.com with SMTP id g127so94957235ywf.2
        for <ceph-devel@vger.kernel.org>; Sun, 07 Feb 2016 21:53:53 -0800 (PST)
In-Reply-To: <CAJE9aOOj3kak2p90RUcD8ps+M_j05NwA-KfYGxZyb3-u1zHkYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--001a11421f006a74b9052b3bd3bf
Content-Type: text/plain; charset=UTF-8

sorry, just sent an out-dated reply.

On Sun, Feb 7, 2016 at 6:12 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> While running run-cli-tests one of the tests dumps while checking if the
> previous command has build the correct crushmap.
> I've verified the actual crushmap against one build on CentOS, and they
> are byte for byte equal.
>
> Before I rebased (from beginning of januari) all these tests completed
> just fine.
>
> During checking I get the following dump:
>
> # src/crushtool -i
> src/tes/cli/crushtool/check-overlapped-rules.crushmap.ref --check
> Assertion failed: (this->_map.find(inter_val) == this->_map.end()),
> function gap_insert, file
> /usr/local/include/boost/icl/interval_base_map.hpp, line 555.
> *** Caught signal (Abort trap) **
>  in thread 803e15000
>  ceph version Development (no_version)
>  1: 0x86f865 <_ZN4ceph9BackTraceC2Ei+0x35> at
> /usr/srcs/Ceph/work/ceph/src/crushtool
>  2: 0x86e5f9 <_ZL19handle_fatal_signali+0xa9> at
> /usr/srcs/Ceph/work/ceph/src/crushtool
>  3: 0x801811c7d <pthread_sigmask+0x50d> at /lib/libthr.so.3
>  4: 0x8018112b2 <pthread_getspecific+0xe22> at /lib/libthr.so.3
> 2016-02-06 22:55:09.075189 803e15000 -1
>
> Deleted remainder of the output....
>
> And I appreciate any pointers in helping me debugging this.

hey Willem, thanks for looking into this. turns out this is a known issue of
boost 1.55. just posted a pull request to workaround it at
https://github.com/ceph/ceph/pull/7560.

also did i create a minimal reproducer, it can help with reproducing this
issue and verify the fix.

you can compile it using:

$ clang++ -std=c++11 -O0 -g test.cc -lm -o test

-- 
Regards
Kefu Chai

On Mon, Feb 8, 2016 at 1:52 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Sun, Feb 7, 2016 at 6:12 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> While running run-cli-tests one of the tests dumps while checking if the
>> previous command has build the correct crushmap.
>> I've verified the actual crushmap against one build on CentOS, and they
>> are byte for byte equal.
>>
>> Before I rebased (from beginning of januari) all these tests completed
>> just fine.
>>
>> During checking I get the following dump:
>>
>> # src/crushtool -i
>> src/tes/cli/crushtool/check-overlapped-rules.crushmap.ref --check
>> Assertion failed: (this->_map.find(inter_val) == this->_map.end()),
>> function gap_insert, file
>> /usr/local/include/boost/icl/interval_base_map.hpp, line 555.
>> *** Caught signal (Abort trap) **
>>  in thread 803e15000
>>  ceph version Development (no_version)
>>  1: 0x86f865 <_ZN4ceph9BackTraceC2Ei+0x35> at
>> /usr/srcs/Ceph/work/ceph/src/crushtool
>>  2: 0x86e5f9 <_ZL19handle_fatal_signali+0xa9> at
>> /usr/srcs/Ceph/work/ceph/src/crushtool
>>  3: 0x801811c7d <pthread_sigmask+0x50d> at /lib/libthr.so.3
>>  4: 0x8018112b2 <pthread_getspecific+0xe22> at /lib/libthr.so.3
>> 2016-02-06 22:55:09.075189 803e15000 -1
>>
>> Deleted remainder of the output....
>>
>> And I appreciate any pointers in helping me debugging this.
>
> Willem, this is a newly added feature for detecting overlapped crush
> rules. i just created a minimal reproducer, hopefull with which one is
> able to have the same crash. it
>
>>
>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Regards
> Kefu Chai



-- 
Regards
Kefu Chai

--001a11421f006a74b9052b3bd3bf
Content-Type: application/octet-stream; name="test.cc"
Content-Disposition: attachment; filename="test.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ikdkblkc1

Ly8gdG8gd29ya2Fyb3VuZCBodHRwczovL3N2bi5ib29zdC5vcmcvdHJhYy9ib29zdC90aWNrZXQv
OTUwMQojaWZkZWYgX0xJQkNQUF9WRVJTSU9OCiNpbmNsdWRlIDxib29zdC9sZXhpY2FsX2Nhc3Qu
aHBwPgovLyAjaW5jbHVkZSA8Ym9vc3QvdmVyc2lvbi5ocHA+CiNpZiBCT09TVF9WRVJTSU9OIDwg
MTA1NjAwCiNkZWZpbmUgSUNMX1VTRV9CT09TVF9NT1ZFX0lNUExFTUVOVEFUSU9OCiNlbmRpZgoj
ZW5kaWYKI2luY2x1ZGUgPGJvb3N0L2ljbC9pbnRlcnZhbF9tYXAuaHBwPgojaW5jbHVkZSA8dmVj
dG9yPgojaW5jbHVkZSA8c3RyaW5nPgojaW5jbHVkZSA8dXRpbGl0eT4KCnVzaW5nIG5hbWVzcGFj
ZSBzdGQ7CgplbnVtIGNsYXNzIFR5cGUgewogIHJlcGxpY2F0ZWQsCiAgZXJhc3VyZSwKfTsKCnN0
cnVjdCBSdWxlIHsKICBzdHJpbmcgbmFtZTsKICBpbnQgcnVsZXNldDsKICBUeXBlIHR5cGU7CiAg
aW50IG1pbl9zaXplOwogIGludCBtYXhfc2l6ZTsKfTsKCnZvaWQgY2hlY2tfb3ZlcmxhcHBlZF9y
dWxlcyhjb25zdCB2ZWN0b3I8UnVsZT4mIHJ1bGVzKQp7CiAgbmFtZXNwYWNlIGljbCA9IGJvb3N0
OjppY2w7CiAgdHlwZWRlZiBzdGQ6OnNldDxzdHJpbmc+IFJ1bGVOYW1lczsKICB0eXBlZGVmIGlj
bDo6aW50ZXJ2YWxfbWFwPGludCwgUnVsZU5hbWVzPiBSdWxlczsKICAvLyA8cnVsZXNldCwgdHlw
ZT4gPT4gaW50ZXJ2YWxfbWFwPHNpemUsIHtuYW1lc30+CiAgdHlwZWRlZiBzdGQ6Om1hcDxzdGQ6
OnBhaXI8aW50LCBUeXBlPiwgUnVsZXM+IFJ1bGVTZXRzOwogIHVzaW5nIGludGVydmFsID0gaWNs
OjppbnRlcnZhbDxpbnQ+OwoKICAvLyBtaW1pYyB0aGUgbG9naWMgb2YgY3J1c2hfZmluZF9ydWxl
KCksIGJ1dCBpdCBvbmx5IHJldHVybiB0aGUgZmlyc3QgbWF0Y2hlZAogIC8vIG9uZSwgYnV0IEkg
YW0gY29sbGVjdGluZyBhbGwgb2YgdGhlbSBieSB0aGUgb3ZlcmxhcHBlZCBzaXplcy4KICBSdWxl
U2V0cyBydWxlc2V0czsKICBmb3IgKGF1dG8gcnVsZSA6IHJ1bGVzKSB7CiAgICBSdWxlcyYgcnVs
ZXMgPSBydWxlc2V0c1t7cnVsZS5ydWxlc2V0LAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJ1bGUudHlwZX1dOwogICAgcnVsZXMgKz0gc3RkOjptYWtlX3BhaXIoaW50ZXJ2YWw6OmNsb3Nl
ZChydWxlLm1pbl9zaXplLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBydWxlLm1heF9zaXplKSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJ1bGVOYW1l
c3tydWxlLm5hbWV9KTsKICB9Cn0KCmludCBtYWluKCkKewogIHZlY3RvcjxSdWxlPiBydWxlcyA9
IHtSdWxleyIwIiwgMCwgVHlwZTo6cmVwbGljYXRlZCwgMSwgM30sCiAgICAgICAgICAgICAgICAg
ICAgICAgIFJ1bGV7IjEiLCAwLCBUeXBlOjpyZXBsaWNhdGVkLCAxLCAxfSwKICAgICAgICAgICAg
ICAgICAgICAgICAgUnVsZXsiMiIsIDAsIFR5cGU6OnJlcGxpY2F0ZWQsIDEsIDJ9LAogICAgICAg
ICAgICAgICAgICAgICAgICBSdWxleyIzIiwgMCwgVHlwZTo6cmVwbGljYXRlZCwgMiwgM30sCiAg
ICAgICAgICAgICAgICAgICAgICAgIFJ1bGV7IjQiLCAwLCBUeXBlOjpyZXBsaWNhdGVkLCA0LCA1
fSwKICAgICAgICAgICAgICAgICAgICAgICAgUnVsZXsiNSIsIDAsIFR5cGU6OmVyYXN1cmUsIDEs
IDEwfSwKICAgICAgICAgICAgICAgICAgICAgICAgUnVsZXsiNiIsIDEsIFR5cGU6OmVyYXN1cmUs
IDEsIDEwfX07CiAgY2hlY2tfb3ZlcmxhcHBlZF9ydWxlcyhydWxlcyk7Cn0K
--001a11421f006a74b9052b3bd3bf--
