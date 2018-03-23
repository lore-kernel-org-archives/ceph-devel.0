From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
Date: Fri, 23 Mar 2018 10:34:01 +0100
Message-ID: <CAOi1vP_7La=nCs71wG3=HbYLaxM3uBFytv8pjGJLuR_uuB0GLg@mail.gmail.com>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
 <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
 <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a113ee646dd9c370568111fa5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP8eLcc6u-XhpSu33+3eDygy3Mp+_tJXT7ygdwsnUs-RmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?5LqA5LqV5LuB5b+XIC8gS0FNRUnvvIxISVRPU0hJ?= <hitoshi.kamei.xm@hitachi.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>, "sage@redhat.com" <sage@redhat.com>, "elder@kernel.org" <elder@kernel.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

--001a113ee646dd9c370568111fa5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 10:31 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Thu, Mar 22, 2018 at 12:57 PM, =E4=BA=80=E4=BA=95=E4=BB=81=E5=BF=97 / =
KAMEI=EF=BC=8CHITOSHI
> <hitoshi.kamei.xm@hitachi.com> wrote:
>> Hi Yang,
>>
>>> I am not sure is this the best way for this case, what about adding an =
option in "rbd map -o thick rbd/test"?
>>
>> I will add such option to the rbd map command to manipulate image settin=
gs. So, the end-user
>> do not change the settings directly via sysfs file.
>>
>>>       @@ -4011,6 +4012,15 @@ static void rbd_queue_workfn(struct work_s=
truct *work)
>>>                       goto err;
>>>               }
>>>
>>>       +       /* Ignore/skip discard requests for thick-provision image=
 */
>>>
>>> Just ignore? or return -EOPNOTSUPP?
>>
>> Thanks, I think -EOPNOTSUPP is better because user programs cannot know
>> the result of requested operation when the kernel rbd driver ignores
>> discard request. The result of requested operation when the kernel rbd d=
river
>> ignores discard requests, which probably misleads the user programs.
>>
>>> In addition, we should not ignore the REQ_OP_WRITE_ZEROES.
>>
>> Relating to the above, the return code of REQ_OP_WRITE_ZEROS request
>> is also -EOPNOTSUPP instead of ignoring. I think the result of
>> -EOPNOTSUPP is also better for this request because the kernel
>> rbd driver can expect that user programs write zero data by itself.
>
> REQ_OP_WRITE_ZEROES should continue to work, we just need to make
> sure it never issues truncates or deletes and instead writes zeroes
> explicitly.
>
> I think we should be explicit about the fact that discard is not
> supported instead of accepting the discard request and failing it in
> rbd_queue_workfn().  Attached patch is what I have in mind.

Now with the patch.

Thanks,

                Ilya

--001a113ee646dd9c370568111fa5
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-rbd-notrim-map-option.patch"
Content-Disposition: attachment; filename="0001-rbd-notrim-map-option.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jf3r0ohl0

RnJvbSAxZGI0MDUzNjYzNzFjYjEyZTUxODI4MTVjMDZmNmY0OTFhZjRiNjNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCAyMyBNYXIgMjAxOCAwOToxNDo0NyArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIHJiZDog
bm90cmltIG1hcCBvcHRpb24KCkFkZCBhbiBvcHRpb24gdG8gdHVybiBvZmYgZGlzY2FyZCBhbmQg
d3JpdGUgemVyb2VzIG9mZmxvYWQgc3VwcG9ydCB0bwphdm9pZCBkZXByb3Zpc2lvbmluZyBhIGZ1
bGx5IHByb3Zpc2lvbmVkIGltYWdlLiAgV2hlbiBlbmFibGVkLCBkaXNjYXJkCnJlcXVlc3RzIHdp
bGwgZmFpbCB3aXRoIC1FT1BOT1RTVVBQLCB3cml0ZSB6ZXJvZXMgcmVxdWVzdHMgd2lsbCBmYWxs
CmJhY2sgdG8gbWFudWFsbHkgemVyb2luZy4KClNpZ25lZC1vZmYtYnk6IElseWEgRHJ5b21vdiA8
aWRyeW9tb3ZAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvYmxvY2svcmJkLmMgfCAxOSArKysrKysr
KysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3JiZC5jIGIvZHJpdmVycy9ibG9jay9y
YmQuYwppbmRleCAxYTkwZTVkZDc0NzAuLmRiZTQ0MGE2NTMxZSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ibG9jay9yYmQuYworKysgYi9kcml2ZXJzL2Jsb2NrL3JiZC5jCkBAIC03MzMsNiArNzMzLDcg
QEAgZW51bSB7CiAJT3B0X3JlYWRfd3JpdGUsCiAJT3B0X2xvY2tfb25fcmVhZCwKIAlPcHRfZXhj
bHVzaXZlLAorCU9wdF9ub3RyaW0sCiAJT3B0X2VycgogfTsKIApAQCAtNzQ2LDYgKzc0Nyw3IEBA
IHN0YXRpYyBtYXRjaF90YWJsZV90IHJiZF9vcHRzX3Rva2VucyA9IHsKIAl7T3B0X3JlYWRfd3Jp
dGUsICJydyJ9LAkJLyogQWx0ZXJuYXRlIHNwZWxsaW5nICovCiAJe09wdF9sb2NrX29uX3JlYWQs
ICJsb2NrX29uX3JlYWQifSwKIAl7T3B0X2V4Y2x1c2l2ZSwgImV4Y2x1c2l2ZSJ9LAorCXtPcHRf
bm90cmltLCAibm90cmltIn0sCiAJe09wdF9lcnIsIE5VTEx9CiB9OwogCkBAIC03NTQsMTIgKzc1
NiwxNCBAQCBzdHJ1Y3QgcmJkX29wdGlvbnMgewogCWJvb2wJcmVhZF9vbmx5OwogCWJvb2wJbG9j
a19vbl9yZWFkOwogCWJvb2wJZXhjbHVzaXZlOworCWJvb2wJdHJpbTsKIH07CiAKICNkZWZpbmUg
UkJEX1FVRVVFX0RFUFRIX0RFRkFVTFQJQkxLREVWX01BWF9SUQogI2RlZmluZSBSQkRfUkVBRF9P
TkxZX0RFRkFVTFQJZmFsc2UKICNkZWZpbmUgUkJEX0xPQ0tfT05fUkVBRF9ERUZBVUxUIGZhbHNl
CiAjZGVmaW5lIFJCRF9FWENMVVNJVkVfREVGQVVMVAlmYWxzZQorI2RlZmluZSBSQkRfVFJJTV9E
RUZBVUxUCXRydWUKIAogc3RhdGljIGludCBwYXJzZV9yYmRfb3B0c190b2tlbihjaGFyICpjLCB2
b2lkICpwcml2YXRlKQogewpAQCAtODAxLDYgKzgwNSw5IEBAIHN0YXRpYyBpbnQgcGFyc2VfcmJk
X29wdHNfdG9rZW4oY2hhciAqYywgdm9pZCAqcHJpdmF0ZSkKIAljYXNlIE9wdF9leGNsdXNpdmU6
CiAJCXJiZF9vcHRzLT5leGNsdXNpdmUgPSB0cnVlOwogCQlicmVhazsKKwljYXNlIE9wdF9ub3Ry
aW06CisJCXJiZF9vcHRzLT50cmltID0gZmFsc2U7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCS8q
IGxpYmNlcGggcHJpbnRzICJiYWQgb3B0aW9uIiBtc2cgKi8KIAkJcmV0dXJuIC1FSU5WQUw7CkBA
IC0zOTQwLDExICszOTQ3LDEyIEBAIHN0YXRpYyBpbnQgcmJkX2luaXRfZGlzayhzdHJ1Y3QgcmJk
X2RldmljZSAqcmJkX2RldikKIAlibGtfcXVldWVfaW9fbWluKHEsIG9ianNldF9ieXRlcyk7CiAJ
YmxrX3F1ZXVlX2lvX29wdChxLCBvYmpzZXRfYnl0ZXMpOwogCi0JLyogZW5hYmxlIHRoZSBkaXNj
YXJkIHN1cHBvcnQgKi8KLQlxdWV1ZV9mbGFnX3NldF91bmxvY2tlZChRVUVVRV9GTEFHX0RJU0NB
UkQsIHEpOwotCXEtPmxpbWl0cy5kaXNjYXJkX2dyYW51bGFyaXR5ID0gb2Jqc2V0X2J5dGVzOwot
CWJsa19xdWV1ZV9tYXhfZGlzY2FyZF9zZWN0b3JzKHEsIG9ianNldF9ieXRlcyA+PiBTRUNUT1Jf
U0hJRlQpOwotCWJsa19xdWV1ZV9tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMocSwgb2Jqc2V0X2J5
dGVzID4+IFNFQ1RPUl9TSElGVCk7CisJaWYgKHJiZF9kZXYtPm9wdHMtPnRyaW0pIHsKKwkJcXVl
dWVfZmxhZ19zZXRfdW5sb2NrZWQoUVVFVUVfRkxBR19ESVNDQVJELCBxKTsKKwkJcS0+bGltaXRz
LmRpc2NhcmRfZ3JhbnVsYXJpdHkgPSBvYmpzZXRfYnl0ZXM7CisJCWJsa19xdWV1ZV9tYXhfZGlz
Y2FyZF9zZWN0b3JzKHEsIG9ianNldF9ieXRlcyA+PiBTRUNUT1JfU0hJRlQpOworCQlibGtfcXVl
dWVfbWF4X3dyaXRlX3plcm9lc19zZWN0b3JzKHEsIG9ianNldF9ieXRlcyA+PiBTRUNUT1JfU0hJ
RlQpOworCX0KIAogCWlmICghY2VwaF90ZXN0X29wdChyYmRfZGV2LT5yYmRfY2xpZW50LT5jbGll
bnQsIE5PQ1JDKSkKIAkJcS0+YmFja2luZ19kZXZfaW5mby0+Y2FwYWJpbGl0aWVzIHw9IEJESV9D
QVBfU1RBQkxFX1dSSVRFUzsKQEAgLTUxNzAsNiArNTE3OCw3IEBAIHN0YXRpYyBpbnQgcmJkX2Fk
ZF9wYXJzZV9hcmdzKGNvbnN0IGNoYXIgKmJ1ZiwKIAlyYmRfb3B0cy0+cXVldWVfZGVwdGggPSBS
QkRfUVVFVUVfREVQVEhfREVGQVVMVDsKIAlyYmRfb3B0cy0+bG9ja19vbl9yZWFkID0gUkJEX0xP
Q0tfT05fUkVBRF9ERUZBVUxUOwogCXJiZF9vcHRzLT5leGNsdXNpdmUgPSBSQkRfRVhDTFVTSVZF
X0RFRkFVTFQ7CisJcmJkX29wdHMtPnRyaW0gPSBSQkRfVFJJTV9ERUZBVUxUOwogCiAJY29wdHMg
PSBjZXBoX3BhcnNlX29wdGlvbnMob3B0aW9ucywgbW9uX2FkZHJzLAogCQkJCQltb25fYWRkcnMg
KyBtb25fYWRkcnNfc2l6ZSAtIDEsCi0tIAoyLjQuMwoK
--001a113ee646dd9c370568111fa5--
