From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: fix osd request encoding regression
Date: Wed, 26 Jul 2017 10:04:09 +0200
Message-ID: <CAOi1vP_rt7TJbmpqVCokdS_r9UrcvvU5rjHpv+-iN=7nMRB_Gg@mail.gmail.com>
References: <20170724132802.7916-1-zyan@redhat.com> <CAOi1vP-oN-_1u3h2owk++=tF9TSRKrDJMBuxAF4FUG1vDy5gvg@mail.gmail.com>
 <E6E0CA48-9FA8-4288-8FF3-27283C1B97DC@redhat.com> <CAOi1vP-LT128qzke8yww+zdHEgenZktQ+RsL8BXVP3kRa2+EbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a114e5bc6973b07055533e4be"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33710 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdGZIEL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jul 2017 04:04:11 -0400
Received: by mail-vk0-f66.google.com with SMTP id o19so2088452vkd.0
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jul 2017 01:04:10 -0700 (PDT)
In-Reply-To: <CAOi1vP-LT128qzke8yww+zdHEgenZktQ+RsL8BXVP3kRa2+EbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--001a114e5bc6973b07055533e4be
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 25, 2017 at 3:33 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Tue, Jul 25, 2017 at 3:14 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>
>>> On 25 Jul 2017, at 21:01, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>
>>> On Mon, Jul 24, 2017 at 3:28 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>>> The new BUG_ON in encode_request_partial() verifies that space used
>>>> by encoding request front is exactly equal to request message size.
>>>> This is wrong because request messages allocated from mempool always
>>>> have size PAGE_SIZE.
>>>>
>>>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>>>> ---
>>>> net/ceph/osd_client.c | 17 +++++++++--------
>>>> 1 file changed, 9 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>>>> index 5c9d696..81f6199 100644
>>>> --- a/net/ceph/osd_client.c
>>>> +++ b/net/ceph/osd_client.c
>>>> @@ -1913,10 +1913,11 @@ static void encode_request_partial(struct ceph_osd_request *req,
>>>>        }
>>>>
>>>>        ceph_encode_32(&p, req->r_attempts); /* retry_attempt */
>>>> -       BUG_ON(p != end - 8); /* space for features */
>>>> +       BUG_ON(p + 8 > end); /* space for features */
>>>>
>>>>        msg->hdr.version = cpu_to_le16(8); /* MOSDOp v8 */
>>>> -       /* front_len is finalized in encode_request_finish() */
>>>> +       msg->front.iov_len = p + 8 - msg->front.iov_base;
>>>> +       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>>>>        msg->hdr.data_len = cpu_to_le32(data_len);
>>>>        /*
>>>>         * The header "data_off" is a hint to the receiver allowing it
>>>> @@ -1932,7 +1933,7 @@ static void encode_request_partial(struct ceph_osd_request *req,
>>>> static void encode_request_finish(struct ceph_msg *msg)
>>>> {
>>>>        void *p = msg->front.iov_base;
>>>> -       void *const end = p + msg->front_alloc_len;
>>>> +       void *const end = p + msg->front.iov_len;
>>>>
>>>>        if (CEPH_HAVE_FEATURE(msg->con->peer_features, RESEND_ON_SPLIT)) {
>>>>                /* luminous OSD -- encode features and be done */
>>>> @@ -2008,11 +2009,11 @@ static void encode_request_finish(struct ceph_msg *msg)
>>>>                p += tail_len;
>>>>
>>>>                msg->hdr.version = cpu_to_le16(4); /* MOSDOp v4 */
>>>> -       }
>>>>
>>>> -       BUG_ON(p > end);
>>>> -       msg->front.iov_len = p - msg->front.iov_base;
>>>> -       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>>>> +               BUG_ON(p > end);
>>>> +               msg->front.iov_len = p - msg->front.iov_base;
>>>> +               msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>>>> +       }
>>>>
>>>>        dout("%s msg %p tid %llu %u+%u+%u v%d\n", __func__, msg,
>>>>             le64_to_cpu(msg->hdr.tid), le32_to_cpu(msg->hdr.front_len),
>>>> @@ -3981,7 +3982,7 @@ static struct ceph_msg *create_backoff_message(
>>>>                return NULL;
>>>>
>>>>        p = msg->front.iov_base;
>>>> -       end = p + msg->front_alloc_len;
>>>> +       end = p + msg->front.iov_len;
>>>>
>>>>        encode_spgid(&p, &backoff->spgid);
>>>>        ceph_encode_32(&p, map_epoch);
>>>
>>> Hi Zheng,
>>>
>>> How about the attached patch instead?  It's shorter and more
>>> importantly preserves the existing structure.
>>
>> does encode_request_finish() get called each time we re-send a message?
>> If it does, your patch seems incorrect. encode_request_finish() appends extra
>> 8 bytes to the message each time it get called.
>
> Hrm, it is.  But then your patch doesn't fix it either because the
> problem is the ->reencode_message() call itself -- I didn't intend it
> to be called on every resend.  Let me run some tests...

OK, so ->reencode_message() being called more than once could affect
the MDS client, but since only the OSD client is using it, there are no
immediate issues.  I'll post the attached patch for the sake of
robustness though.

Thanks,

                Ilya

--001a114e5bc6973b07055533e4be
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-libceph-don-t-call-reencode_message-more-than-once-p.patch"
Content-Disposition: attachment;
	filename="0001-libceph-don-t-call-reencode_message-more-than-once-p.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5kq2pg80

RnJvbSA4NTI0YjU3YTU4ODFiNTQ4ZWNiMTdiMTUwYWFmNTk5ZTY0N2I4OTgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCAyNiBKdWwgMjAxNyAwOTo1OToxNSArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGxpYmNl
cGg6IGRvbid0IGNhbGwgLT5yZWVuY29kZV9tZXNzYWdlKCkgbW9yZSB0aGFuIG9uY2UgcGVyCiBt
ZXNzYWdlCgpSZWVuY29kaW5nIGFuIGFscmVhZHkgcmVlbmNvZGVkIG1lc3NhZ2UgaXMgYSBiYWQg
aWRlYS4gIFRoaXMgY291bGQKaGFwcGVuIG9uIFBvbGljeTo6c3RhdGVmdWxfc2VydmVyIGNvbm5l
Y3Rpb25zICghQ0VQSF9NU0dfQ09OTkVDVF9MT1NTWSksCnN1Y2ggYXMgTURTIHNlc3Npb25zLgoK
VGhpcyBkaWRuJ3QgcG9wIHVwIGluIHRlc3RpbmcgYmVjYXVzZSBjdXJyZW50bHkgb25seSBPU0Qg
cmVxdWVzdHMgYXJlCnJlZW5jb2RlZCBhbmQgT1NEIHNlc3Npb25zIGFyZSBhbHdheXMgbG9zc3ku
CgpGaXhlczogOThhZDVlYmQxNTA1ICgibGliY2VwaDogY2VwaF9jb25uZWN0aW9uX29wZXJhdGlv
bnM6OnJlZW5jb2RlX21lc3NhZ2UoKSBtZXRob2QiKQpTaWduZWQtb2ZmLWJ5OiBJbHlhIERyeW9t
b3YgPGlkcnlvbW92QGdtYWlsLmNvbT4KLS0tCiBuZXQvY2VwaC9tZXNzZW5nZXIuYyB8IDYgKysr
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL25ldC9jZXBoL21lc3Nlbmdlci5jIGIvbmV0L2NlcGgvbWVzc2VuZ2VyLmMKaW5k
ZXggYjdjYzYxNWQ0MmVmLi5hNjcyOThjN2UwY2QgMTAwNjQ0Ci0tLSBhL25ldC9jZXBoL21lc3Nl
bmdlci5jCisrKyBiL25ldC9jZXBoL21lc3Nlbmdlci5jCkBAIC0xMjg3LDEwICsxMjg3LDEwIEBA
IHN0YXRpYyB2b2lkIHByZXBhcmVfd3JpdGVfbWVzc2FnZShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9u
ICpjb24pCiAJaWYgKG0tPm5lZWRzX291dF9zZXEpIHsKIAkJbS0+aGRyLnNlcSA9IGNwdV90b19s
ZTY0KCsrY29uLT5vdXRfc2VxKTsKIAkJbS0+bmVlZHNfb3V0X3NlcSA9IGZhbHNlOwotCX0KIAot
CWlmIChjb24tPm9wcy0+cmVlbmNvZGVfbWVzc2FnZSkKLQkJY29uLT5vcHMtPnJlZW5jb2RlX21l
c3NhZ2UobSk7CisJCWlmIChjb24tPm9wcy0+cmVlbmNvZGVfbWVzc2FnZSkKKwkJCWNvbi0+b3Bz
LT5yZWVuY29kZV9tZXNzYWdlKG0pOworCX0KIAogCWRvdXQoInByZXBhcmVfd3JpdGVfbWVzc2Fn
ZSAlcCBzZXEgJWxsZCB0eXBlICVkIGxlbiAlZCslZCslemRcbiIsCiAJICAgICBtLCBjb24tPm91
dF9zZXEsIGxlMTZfdG9fY3B1KG0tPmhkci50eXBlKSwKLS0gCjIuNC4zCgo=
--001a114e5bc6973b07055533e4be--
