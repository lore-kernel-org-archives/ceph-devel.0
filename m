From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Issue with Ceph File System and LIO
Date: Wed, 16 Dec 2015 22:29:52 +0800
Message-ID: <CAAM7YAnktfNvd-EXU+1Eok4kUafWwnvj+CCGocF7ffTcAt-dsA@mail.gmail.com>
References: <CA+9C14a0E9bc+GL-QiAxPD_B9_PRhEE4PRG2jAa9REWkdNQFiA@mail.gmail.com>
	<CAAM7YAk=U7NqEujuMXAyem00NDJfx-TOYGgJez76f48HS6nt2A@mail.gmail.com>
	<CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114035ec51f530052704bdee
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35968 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933796AbbLPO3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 09:29:54 -0500
Received: by mail-lf0-f41.google.com with SMTP id z124so25573697lfa.3
        for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 06:29:54 -0800 (PST)
In-Reply-To: <CA+9C14ZOZQcWSGL8ukDeVQAtoTEDRNOLq=CB1ZusiMsx6-seMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric.eastman@keepertech.com>
Cc: spray@redhat.com, mchristi@redhat.com, Ceph Development <ceph-devel@vger.kernel.org>

--001a114035ec51f530052704bdee
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 16, 2015 at 12:51 AM, Eric Eastman
<eric.eastman@keepertech.com> wrote:
> I have opened ticket: 14086
>
> On Tue, Dec 15, 2015 at 5:05 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Tue, Dec 15, 2015 at 2:08 PM, Eric Eastman
>>> [Tue Dec 15 00:46:55 2015] ------------[ cut here ]------------
>>> [Tue Dec 15 00:46:55 2015] WARNING: CPU: 0 PID: 1123421 at
>>> /home/kernel/COD/linux/fs/ceph/addr.c:125
>>
>> could you confirm that addr.c:125 is WARN_ON(!PageLocked(page));
>
> I am using the generic kernel from:
> http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.4-rc4-wily
> and assuming they did not change anything, from the 4.4rc4 source tree
> I pulled down shows:
>
> 124         ret = __set_page_dirty_nobuffers(page);
> 125         WARN_ON(!PageLocked(page));
> 126         WARN_ON(!page->mapping);
>
>
> modinfo ceph
> filename:       /lib/modules/4.4.0-040400rc4-generic/kernel/fs/ceph/ceph.ko
> license:        GPL
> description:    Ceph filesystem for Linux
> author:         Patience Warnick <patience@newdream.net>
> author:         Yehuda Sadeh <yehuda@hq.newdream.net>
> author:         Sage Weil <sage@newdream.net>
> alias:          fs-ceph
> srcversion:     E94BA78C2D998705FE2C600
> depends:        libceph,fscache
> intree:         Y
> vermagic:       4.4.0-040400rc4-generic SMP mod_unload modversions
>
> This error has shown up about 20 times in 12 hours, since I started
> the ESXi test.
>

This warning is really strange. Could you try the attached debug patch.

Regards
Yan, Zheng

--001a114035ec51f530052704bdee
Content-Type: application/octet-stream; name="cephfs.patch"
Content-Disposition: attachment; filename="cephfs.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ii8wwok10

ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMKaW5kZXggYjdkMjE4
YS4uOTg4YmRhNCAxMDA2NDQKLS0tIGEvZnMvY2VwaC9hZGRyLmMKKysrIGIvZnMvY2VwaC9hZGRy
LmMKQEAgLTExNDksMTYgKzExNDksMTkgQEAgc3RhdGljIGludCBjZXBoX3dyaXRlX2JlZ2luKHN0
cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywKIAkJcGFnZSA9
IGdyYWJfY2FjaGVfcGFnZV93cml0ZV9iZWdpbihtYXBwaW5nLCBpbmRleCwgMCk7CiAJCWlmICgh
cGFnZSkKIAkJCXJldHVybiAtRU5PTUVNOworCQlXQVJOX09OKCFQYWdlTG9ja2VkKHBhZ2UpKTsK
IAkJKnBhZ2VwID0gcGFnZTsKIAogCQlkb3V0KCJ3cml0ZV9iZWdpbiBmaWxlICVwIGlub2RlICVw
IHBhZ2UgJXAgJWR+JWRcbiIsIGZpbGUsCiAJCSAgICAgaW5vZGUsIHBhZ2UsIChpbnQpcG9zLCAo
aW50KWxlbik7CiAKIAkJciA9IGNlcGhfdXBkYXRlX3dyaXRlYWJsZV9wYWdlKGZpbGUsIHBvcywg
bGVuLCBwYWdlKTsKLQkJaWYgKHIgPCAwKQorCQlpZiAociA8IDApIHsKIAkJCXBhZ2VfY2FjaGVf
cmVsZWFzZShwYWdlKTsKLQkJZWxzZQorCQl9IGVsc2UgeworCQkJV0FSTl9PTighUGFnZUxvY2tl
ZChwYWdlKSk7CiAJCQkqcGFnZXAgPSBwYWdlOworCQl9CiAJfSB3aGlsZSAociA9PSAtRUFHQUlO
KTsKIAogCXJldHVybiByOwpAQCAtMTM3OCwxMSArMTM4MSwxMyBAQCBzdGF0aWMgaW50IGNlcGhf
cGFnZV9ta3dyaXRlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBzdHJ1Y3Qgdm1fZmF1bHQg
KnZtZikKIAogCXJldCA9IFZNX0ZBVUxUX05PUEFHRTsKIAlpZiAoKG9mZiA+IHNpemUpIHx8Ci0J
ICAgIChwYWdlLT5tYXBwaW5nICE9IGlub2RlLT5pX21hcHBpbmcpKQorCSAgICAocGFnZS0+bWFw
cGluZyAhPSBpbm9kZS0+aV9tYXBwaW5nKSkgeworCQl1bmxvY2tfcGFnZShwYWdlKTsKIAkJZ290
byBvdXQ7CisJfQogCiAJcmV0ID0gY2VwaF91cGRhdGVfd3JpdGVhYmxlX3BhZ2Uodm1hLT52bV9m
aWxlLCBvZmYsIGxlbiwgcGFnZSk7Ci0JaWYgKHJldCA9PSAwKSB7CisJaWYgKHJldCA+PSAwKSB7
CiAJCS8qIHN1Y2Nlc3MuICB3ZSdsbCBrZWVwIHRoZSBwYWdlIGxvY2tlZC4gKi8KIAkJc2V0X3Bh
Z2VfZGlydHkocGFnZSk7CiAJCXJldCA9IFZNX0ZBVUxUX0xPQ0tFRDsKQEAgLTEzOTMsOCArMTM5
OCw2IEBAIHN0YXRpYyBpbnQgY2VwaF9wYWdlX21rd3JpdGUoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsIHN0cnVjdCB2bV9mYXVsdCAqdm1mKQogCQkJcmV0ID0gVk1fRkFVTFRfU0lHQlVTOwog
CX0KIG91dDoKLQlpZiAocmV0ICE9IFZNX0ZBVUxUX0xPQ0tFRCkKLQkJdW5sb2NrX3BhZ2UocGFn
ZSk7CiAJaWYgKHJldCA9PSBWTV9GQVVMVF9MT0NLRUQgfHwKIAkgICAgY2ktPmlfaW5saW5lX3Zl
cnNpb24gIT0gQ0VQSF9JTkxJTkVfTk9ORSkgewogCQlpbnQgZGlydHk7Cg==
--001a114035ec51f530052704bdee--
