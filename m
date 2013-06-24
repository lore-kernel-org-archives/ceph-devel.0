From: christophe courtaut <christophe.courtaut@gmail.com>
Subject: Re: [PATCH] rgw: Added an encoder for time_t to fix compilation
Date: Mon, 24 Jun 2013 16:36:14 +0200
Message-ID: <CAA8043j7SpO-93KEgk1JQD=BYV=H8GwQVZYz=2LhkSZgVF+dBA@mail.gmail.com>
References: <CAA8043gcmGmpNba7OEbh8Vo7-SgUN_R_CcGpsi_Vt9pgmmhirw@mail.gmail.com>
 <CABBk=J8J_tKY-Wy-sWb2=GREauqN0GfaJaHk14jzRVM0fx59Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11334794e3f0ee04dfe75632
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33756 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab3FXOgf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 10:36:35 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so10843461obc.38
        for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 07:36:35 -0700 (PDT)
In-Reply-To: <CABBk=J8J_tKY-Wy-sWb2=GREauqN0GfaJaHk14jzRVM0fx59Bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

--001a11334794e3f0ee04dfe75632
Content-Type: text/plain; charset=ISO-8859-1

Here come a new patch.

I do not generate an encoder/decoder using WRITE_RAW_ENCODER anymore.

Instead i added a encoder/decoder for time_t using a __u64.

On Thu, Jun 20, 2013 at 10:44 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Thu, Jun 20, 2013 at 6:57 AM, christophe courtaut
> <christophe.courtaut@gmail.com> wrote:
>> On the rgw-wip-geo-2 branch, the encode decode function are called
>> with time_t now,
>> but there is no encode/decode function created for time_t type.
>>
>> http://tracker.ceph.com/issues/5402 refs #5402
>>
>> This patch adds a WRITE_RAW_ENCODER to support this type.
>>
>> --
>> Christophe Courtaut
>
>
> The problem here is that we can't use the generic encoder / decoder as
> time_t may have different size on different architectures. We should
> just have a fixed size encoding for it (probably 64 bit albeit the
> waste).
>
> Thanks,
> Yehuda



-- 
Christophe Courtaut

--001a11334794e3f0ee04dfe75632
Content-Type: application/octet-stream;
	name="0001-rgw-Added-an-encoder-for-time_t-to-fix-compilation.patch"
Content-Disposition: attachment;
	filename="0001-rgw-Added-an-encoder-for-time_t-to-fix-compilation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hibrq17f0

RnJvbSAxMjVjZWNkMzExOTRhOGM5MjEwNzFiZWQwYjFkM2VjNDBiMDg2YTlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RvcGhlIENvdXJ0YXV0IDxjaHJpc3RvcGhlLmNvdXJ0
YXV0QGdtYWlsLmNvbT4KRGF0ZTogVGh1LCAyMCBKdW4gMjAxMyAxNTo1MDozNCArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIHJndzogQWRkZWQgYW4gZW5jb2RlciBmb3IgdGltZV90IHRvIGZpeCBjb21w
aWxhdGlvbgoKVGhlIGVuY29kZSBkZWNvZGUgZnVuY3Rpb24gYXJlIGNhbGxlZCB3aXRoIHRpbWVf
dCBub3csCmJ1dCB0aGVyZSBpcyBubyBlbmNvZGUvZGVjb2RlIGZ1bmN0aW9uIGNyZWF0ZWQgZm9y
IHRpbWVfdCB0eXBlLgoKaHR0cDovL3RyYWNrZXIuY2VwaC5jb20vaXNzdWVzLzU0MDIgcmVmcyAj
NTQwMgoKVGhpcyBwYXRjaCBhZGRzIGEgV1JJVEVfUkFXX0VOQ09ERVIgdG8gc3VwcG9ydCB0aGlz
IHR5cGUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIENvdXJ0YXV0IDxjaHJpc3RvcGhlLmNv
dXJ0YXV0QGdtYWlsLmNvbT4KLS0tCiBzcmMvaW5jbHVkZS9lbmNvZGluZy5oIHwgMSArCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zcmMvaW5jbHVkZS9lbmNv
ZGluZy5oIGIvc3JjL2luY2x1ZGUvZW5jb2RpbmcuaAppbmRleCBlYjQ0NWUzLi40ZTlmNzIyIDEw
MDY0NAotLS0gYS9zcmMvaW5jbHVkZS9lbmNvZGluZy5oCisrKyBiL3NyYy9pbmNsdWRlL2VuY29k
aW5nLmgKQEAgLTY3LDYgKzY3LDcgQEAgV1JJVEVfUkFXX0VOQ09ERVIoY2hhcikKIFdSSVRFX1JB
V19FTkNPREVSKGNlcGhfbGU2NCkKIFdSSVRFX1JBV19FTkNPREVSKGNlcGhfbGUzMikKIFdSSVRF
X1JBV19FTkNPREVSKGNlcGhfbGUxNikKK1dSSVRFX1JBV19FTkNPREVSKHRpbWVfdCkKIAogLy8g
RklYTUU6IHdlIG5lZWQgdG8gY2hvb3NlIHNvbWUgcG9ydGFibGUgZmxvYXRpbmcgcG9pbnQgZW5j
b2RpbmcgaGVyZQogV1JJVEVfUkFXX0VOQ09ERVIoZmxvYXQpCi0tIAoxLjguMS4yCgo=
--001a11334794e3f0ee04dfe75632--
