From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: Re: [PATCH] rgw: Added an encoder for time_t to fix compilation
Date: Mon, 24 Jun 2013 17:13:32 +0200
Message-ID: <CAA8043gJKa-t_DWeHE-OeGThNGwdMjb83Ve4ENSxcUU3nSFM6Q@mail.gmail.com>
References: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com>
 <CABBk=J8J_tKY-Wy-sWb2=GREauqN0GfaJaHk14jzRVM0fx59Bg@mail.gmail.com> <CAA8043j7SpO-93KEgk1JQD=BYV=H8GwQVZYz=2LhkSZgVF+dBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e01294e564b5bf704dfe7dca3
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39010 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab3FXPNx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 11:13:53 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so10717795obq.7
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 08:13:53 -0700 (PDT)
In-Reply-To: <CAA8043j7SpO-93KEgk1JQD=BYV=H8GwQVZYz=2LhkSZgVF+dBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

--089e01294e564b5bf704dfe7dca3
Content-Type: text/plain; charset=ISO-8859-1

Sorry, wrong patch attached.

Here comes the updated version.

Best regards.

On Mon, Jun 24, 2013 at 4:36 PM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
> Here come a new patch.
>
> I do not generate an encoder/decoder using WRITE_RAW_ENCODER anymore.
>
> Instead i added a encoder/decoder for time_t using a __u64.
>
> On Thu, Jun 20, 2013 at 10:44 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> On Thu, Jun 20, 2013 at 6:57 AM, christophe courtaut
>> <christophe.courtaut@gmail.com> wrote:
>>> On the rgw-wip-geo-2 branch, the encode decode function are called
>>> with time_t now,
>>> but there is no encode/decode function created for time_t type.
>>>
>>> http://tracker.ceph.com/issues/5402 refs #5402
>>>
>>> This patch adds a WRITE_RAW_ENCODER to support this type.
>>>
>>> --
>>> Christophe Courtaut
>>
>>
>> The problem here is that we can't use the generic encoder / decoder as
>> time_t may have different size on different architectures. We should
>> just have a fixed size encoding for it (probably 64 bit albeit the
>> waste).
>>
>> Thanks,
>> Yehuda
>
>
>
> --
> Christophe Courtaut



-- 
Christophe Courtaut

--089e01294e564b5bf704dfe7dca3
Content-Type: application/octet-stream;
	name="0001-rgw-Added-an-encoder-for-time_t-to-fix-compilation.patch"
Content-Disposition: attachment;
	filename="0001-rgw-Added-an-encoder-for-time_t-to-fix-compilation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hibrzizc1

RnJvbSAzNmQzMmI0YWY2ZDM3YTQyNmNkMjU1YWRlNTA2MjBjYTQxNWNhMmFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlIENvdXJ0YXV0IDxjaHJpc3RvcGhlLmNvdXJ0
YXV0QGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAyMCBKdW4gMjAxMyAxNTo1MDozNCArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIHJndzogQWRkZWQgYW4gZW5jb2RlciBmb3IgdGltZV90IHRvIGZpeCBjb21w
aWxhdGlvbgoKVGhlIGVuY29kZSBkZWNvZGUgZnVuY3Rpb24gYXJlIGNhbGxlZCB3aXRoIHRpbWVf
dCBub3csCmJ1dCB0aGVyZSBpcyBubyBlbmNvZGUvZGVjb2RlIGZ1bmN0aW9uIGNyZWF0ZWQgZm9y
IHRpbWVfdCB0eXBlLgoKaHR0cDovL3RyYWNrZXIuY2VwaC5jb20vaXNzdWVzLzU0MDIgcmVmcyAj
NTQwMgoKVGhpcyBwYXRjaCBhZGRzIGEgZml4ZWQgc2l6ZWQgZW5jb2Rlci9kZWNvZGVyIG9uIDY0
Yml0cyB0byBzdXBwb3J0IHRoaXMgdHlwZS4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgQ291
cnRhdXQgPGNocmlzdG9waGUuY291cnRhdXRAZ21haWwuY29tPgotLS0KIHNyYy9pbmNsdWRlL2Vu
Y29kaW5nLmggfCA5ICsrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL3NyYy9pbmNsdWRlL2VuY29kaW5nLmggYi9zcmMvaW5jbHVkZS9lbmNvZGlu
Zy5oCmluZGV4IGViNDQ1ZTMuLjdhMWNmYWQgMTAwNjQ0Ci0tLSBhL3NyYy9pbmNsdWRlL2VuY29k
aW5nLmgKKysrIGIvc3JjL2luY2x1ZGUvZW5jb2RpbmcuaApAQCAtODIsNiArODIsMTUgQEAgaW5s
aW5lIHZvaWQgZGVjb2RlKGJvb2wgJnYsIGJ1ZmZlcmxpc3Q6Oml0ZXJhdG9yJiBwKSB7CiAgIHYg
PSB2djsKIH0KIAoraW5saW5lIHZvaWQgZW5jb2RlKGNvbnN0IHRpbWVfdCAmdiwgYnVmZmVybGlz
dCYgYmwpIHsKKyAgX191NjQgdnYgPSB2OworICBlbmNvZGVfcmF3KHZ2LCBibCk7Cit9Citpbmxp
bmUgdm9pZCBkZWNvZGUodGltZV90ICZ2LCBidWZmZXJsaXN0OjppdGVyYXRvciYgcCkgeworICBf
X3U2NCB2djsKKyAgZGVjb2RlX3Jhdyh2diwgcCk7CisgIHYgPSB2djsKK30KIAogLy8gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIC8vIGludCB0eXBlcwotLSAKMS44LjEuMgoK
--089e01294e564b5bf704dfe7dca3--
