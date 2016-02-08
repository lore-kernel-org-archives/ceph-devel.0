From: kefu chai <tchaikov@gmail.com>
Subject: Re: FreeBSD crushtool crashing while checking a crushmap
Date: Mon, 8 Feb 2016 13:52:04 +0800
Message-ID: <CAJE9aOOj3kak2p90RUcD8ps+M_j05NwA-KfYGxZyb3-u1zHkYw@mail.gmail.com>
References: <56B66FC0.70409@digiware.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c09d7c2ed0ded052b3bcca5
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36528 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcBHFwG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 00:52:06 -0500
Received: by mail-yk0-f180.google.com with SMTP id z7so83095143yka.3
        for <ceph-devel@vger.kernel.org>; Sun, 07 Feb 2016 21:52:05 -0800 (PST)
In-Reply-To: <56B66FC0.70409@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--94eb2c09d7c2ed0ded052b3bcca5
Content-Type: text/plain; charset=UTF-8

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

Willem, this is a newly added feature for detecting overlapped crush
rules. i just created a minimal reproducer, hopefull with which one is
able to have the same crash. it

>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai

--94eb2c09d7c2ed0ded052b3bcca5
Content-Type: application/octet-stream; name="test.cc"
Content-Disposition: attachment; filename="test.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ikdi3j720

I2luY2x1ZGUgPGJvb3N0L2ljbC9pbnRlcnZhbF9tYXAuaHBwPgojaW5jbHVkZSA8dmVjdG9yPgoj
aW5jbHVkZSA8c3RyaW5nPgojaW5jbHVkZSA8dXRpbGl0eT4KCnVzaW5nIG5hbWVzcGFjZSBzdGQ7
CgplbnVtIGNsYXNzIFR5cGUgewogIHJlcGxpY2F0ZWQsCiAgZXJhc3VyZSwKfTsKCnN0cnVjdCBS
dWxlIHsKICBzdHJpbmcgbmFtZTsKICBpbnQgcnVsZXNldDsKICBUeXBlIHR5cGU7CiAgaW50IG1p
bl9zaXplOwogIGludCBtYXhfc2l6ZTsKfTsKCnZvaWQgY2hlY2tfb3ZlcmxhcHBlZF9ydWxlcyhj
b25zdCB2ZWN0b3I8UnVsZT4mIHJ1bGVzKQp7ICAKICBuYW1lc3BhY2UgaWNsID0gYm9vc3Q6Omlj
bDsKICB0eXBlZGVmIHN0ZDo6c2V0PHN0cmluZz4gUnVsZU5hbWVzOwogIHR5cGVkZWYgaWNsOjpp
bnRlcnZhbF9tYXA8aW50LCBSdWxlTmFtZXM+IFJ1bGVzOwogIC8vIDxydWxlc2V0LCB0eXBlPiA9
PiBpbnRlcnZhbF9tYXA8c2l6ZSwge25hbWVzfT4KICB0eXBlZGVmIHN0ZDo6bWFwPHN0ZDo6cGFp
cjxpbnQsIFR5cGU+LCBSdWxlcz4gUnVsZVNldHM7CiAgdXNpbmcgaW50ZXJ2YWwgPSBpY2w6Omlu
dGVydmFsPGludD47CgogIC8vIG1pbWljIHRoZSBsb2dpYyBvZiBjcnVzaF9maW5kX3J1bGUoKSwg
YnV0IGl0IG9ubHkgcmV0dXJuIHRoZSBmaXJzdCBtYXRjaGVkCiAgLy8gb25lLCBidXQgSSBhbSBj
b2xsZWN0aW5nIGFsbCBvZiB0aGVtIGJ5IHRoZSBvdmVybGFwcGVkIHNpemVzLgogIFJ1bGVTZXRz
IHJ1bGVzZXRzOwogIGZvciAoYXV0byBydWxlIDogcnVsZXMpIHsKICAgIFJ1bGVzJiBydWxlcyA9
IHJ1bGVzZXRzW3tydWxlLnJ1bGVzZXQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnVs
ZS50eXBlfV07CiAgICBydWxlcyArPSBzdGQ6Om1ha2VfcGFpcihpbnRlcnZhbDo6Y2xvc2VkKHJ1
bGUubWluX3NpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJ1bGUubWF4X3NpemUpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgUnVsZU5hbWVze3J1
bGUubmFtZX0pOwogIH0KfQoKaW50IG1haW4oKQp7CiAgdmVjdG9yPFJ1bGU+IHJ1bGVzID0ge1J1
bGV7IjAiLCAwLCBUeXBlOjpyZXBsaWNhdGVkLCAxLCAzfSwKICAgICAgICAgICAgICAgICAgICAg
ICAgUnVsZXsiMSIsIDAsIFR5cGU6OnJlcGxpY2F0ZWQsIDEsIDF9LAogICAgICAgICAgICAgICAg
ICAgICAgICBSdWxleyIyIiwgMCwgVHlwZTo6cmVwbGljYXRlZCwgMSwgMn0sCiAgICAgICAgICAg
ICAgICAgICAgICAgIFJ1bGV7IjMiLCAwLCBUeXBlOjpyZXBsaWNhdGVkLCAyLCAzfSwKICAgICAg
ICAgICAgICAgICAgICAgICAgUnVsZXsiNCIsIDAsIFR5cGU6OnJlcGxpY2F0ZWQsIDQsIDV9LAog
ICAgICAgICAgICAgICAgICAgICAgICBSdWxleyI1IiwgMCwgVHlwZTo6ZXJhc3VyZSwgMSwgMTB9
LAogICAgICAgICAgICAgICAgICAgICAgICBSdWxleyI2IiwgMSwgVHlwZTo6ZXJhc3VyZSwgMSwg
MTB9fTsKICBjaGVja19vdmVybGFwcGVkX3J1bGVzKHJ1bGVzKTsKfQo=
--94eb2c09d7c2ed0ded052b3bcca5--
