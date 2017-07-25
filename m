From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: fix osd request encoding regression
Date: Tue, 25 Jul 2017 15:01:28 +0200
Message-ID: <CAOi1vP-oN-_1u3h2owk++=tF9TSRKrDJMBuxAF4FUG1vDy5gvg@mail.gmail.com>
References: <20170724132802.7916-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a1144109609a869055523eea2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38639 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdGYNBa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jul 2017 09:01:30 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24so12262989uah.5
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jul 2017 06:01:29 -0700 (PDT)
In-Reply-To: <20170724132802.7916-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--001a1144109609a869055523eea2
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 24, 2017 at 3:28 PM, Yan, Zheng <zyan@redhat.com> wrote:
> The new BUG_ON in encode_request_partial() verifies that space used
> by encoding request front is exactly equal to request message size.
> This is wrong because request messages allocated from mempool always
> have size PAGE_SIZE.
>
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  net/ceph/osd_client.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5c9d696..81f6199 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1913,10 +1913,11 @@ static void encode_request_partial(struct ceph_osd_request *req,
>         }
>
>         ceph_encode_32(&p, req->r_attempts); /* retry_attempt */
> -       BUG_ON(p != end - 8); /* space for features */
> +       BUG_ON(p + 8 > end); /* space for features */
>
>         msg->hdr.version = cpu_to_le16(8); /* MOSDOp v8 */
> -       /* front_len is finalized in encode_request_finish() */
> +       msg->front.iov_len = p + 8 - msg->front.iov_base;
> +       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>         msg->hdr.data_len = cpu_to_le32(data_len);
>         /*
>          * The header "data_off" is a hint to the receiver allowing it
> @@ -1932,7 +1933,7 @@ static void encode_request_partial(struct ceph_osd_request *req,
>  static void encode_request_finish(struct ceph_msg *msg)
>  {
>         void *p = msg->front.iov_base;
> -       void *const end = p + msg->front_alloc_len;
> +       void *const end = p + msg->front.iov_len;
>
>         if (CEPH_HAVE_FEATURE(msg->con->peer_features, RESEND_ON_SPLIT)) {
>                 /* luminous OSD -- encode features and be done */
> @@ -2008,11 +2009,11 @@ static void encode_request_finish(struct ceph_msg *msg)
>                 p += tail_len;
>
>                 msg->hdr.version = cpu_to_le16(4); /* MOSDOp v4 */
> -       }
>
> -       BUG_ON(p > end);
> -       msg->front.iov_len = p - msg->front.iov_base;
> -       msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> +               BUG_ON(p > end);
> +               msg->front.iov_len = p - msg->front.iov_base;
> +               msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> +       }
>
>         dout("%s msg %p tid %llu %u+%u+%u v%d\n", __func__, msg,
>              le64_to_cpu(msg->hdr.tid), le32_to_cpu(msg->hdr.front_len),
> @@ -3981,7 +3982,7 @@ static struct ceph_msg *create_backoff_message(
>                 return NULL;
>
>         p = msg->front.iov_base;
> -       end = p + msg->front_alloc_len;
> +       end = p + msg->front.iov_len;
>
>         encode_spgid(&p, &backoff->spgid);
>         ceph_encode_32(&p, map_epoch);

Hi Zheng,

How about the attached patch instead?  It's shorter and more
importantly preserves the existing structure.

What is create_backoff_message() hunk for?  Backoff messages are
never allocated out of ceph_msgpool.

Thanks,

                Ilya

--001a1144109609a869055523eea2
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-libceph-make-encode_request_-work-with-r_mempool-req.patch"
Content-Disposition: attachment;
	filename="0001-libceph-make-encode_request_-work-with-r_mempool-req.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j5jl9jta0

RnJvbSBjYTA3NGMxM2YxNTllMTBmMGIwY2MzZjJhZjc0NjQ3OTI1ZTYwMGYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4KRGF0
ZTogVHVlLCAyNSBKdWwgMjAxNyAxNDo0MDowMyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIGxpYmNl
cGg6IG1ha2UgZW5jb2RlX3JlcXVlc3RfKigpIHdvcmsgd2l0aCByX21lbXBvb2wgcmVxdWVzdHMK
Ck1lc3NhZ2VzIGFsbG9jYXRlZCBvdXQgb2YgY2VwaF9tc2dwb29sIGhhdmUgYSBmaXhlZCBmcm9u
dCBsZW5ndGgKKHBvb2wtPmZyb250X2xlbikuICBBc3NlcnRpbmcgdGhhdCB0aGUgZW50aXJlIGZy
b250IGhhcyBiZWVuIGZpbGxlZAp3aGlsZSBlbmNvZGluZyBpcyB0aHVzIHdyb25nLgoKRml4ZXM6
IDhjYjQ0MWMwNTQ1ZCAoImxpYmNlcGg6IE1PU0RPcCB2OCBlbmNvZGluZyAoYWN0dWFsIHNwZ2lk
ICsgZnVsbCBoYXNoKSIpClJlcG9ydGVkLWJ5OiAiWWFuLCBaaGVuZyIgPHp5YW5AcmVkaGF0LmNv
bT4KU2lnbmVkLW9mZi1ieTogSWx5YSBEcnlvbW92IDxpZHJ5b21vdkBnbWFpbC5jb20+Ci0tLQog
bmV0L2NlcGgvb3NkX2NsaWVudC5jIHwgOSArKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvb3NkX2Ns
aWVudC5jIGIvbmV0L2NlcGgvb3NkX2NsaWVudC5jCmluZGV4IDkwMWJiODIyMTM2Ni4uYjVmMDE2
Y2I5NTY5IDEwMDY0NAotLS0gYS9uZXQvY2VwaC9vc2RfY2xpZW50LmMKKysrIGIvbmV0L2NlcGgv
b3NkX2NsaWVudC5jCkBAIC0xOTE4LDEwICsxOTE4LDEyIEBAIHN0YXRpYyB2b2lkIGVuY29kZV9y
ZXF1ZXN0X3BhcnRpYWwoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKnJlcSwKIAl9CiAKIAljZXBo
X2VuY29kZV8zMigmcCwgcmVxLT5yX2F0dGVtcHRzKTsgLyogcmV0cnlfYXR0ZW1wdCAqLwotCUJV
R19PTihwICE9IGVuZCAtIDgpOyAvKiBzcGFjZSBmb3IgZmVhdHVyZXMgKi8KKwlCVUdfT04ocCA+
IGVuZCAtIDgpOyAvKiBzcGFjZSBmb3IgZmVhdHVyZXMgKi8KIAogCW1zZy0+aGRyLnZlcnNpb24g
PSBjcHVfdG9fbGUxNig4KTsgLyogTU9TRE9wIHY4ICovCiAJLyogZnJvbnRfbGVuIGlzIGZpbmFs
aXplZCBpbiBlbmNvZGVfcmVxdWVzdF9maW5pc2goKSAqLworCW1zZy0+ZnJvbnQuaW92X2xlbiA9
IHAgLSBtc2ctPmZyb250Lmlvdl9iYXNlOworCW1zZy0+aGRyLmZyb250X2xlbiA9IGNwdV90b19s
ZTMyKG1zZy0+ZnJvbnQuaW92X2xlbik7CiAJbXNnLT5oZHIuZGF0YV9sZW4gPSBjcHVfdG9fbGUz
MihkYXRhX2xlbik7CiAJLyoKIAkgKiBUaGUgaGVhZGVyICJkYXRhX29mZiIgaXMgYSBoaW50IHRv
IHRoZSByZWNlaXZlciBhbGxvd2luZyBpdApAQCAtMTkzNywxMSArMTkzOSwxMiBAQCBzdGF0aWMg
dm9pZCBlbmNvZGVfcmVxdWVzdF9wYXJ0aWFsKHN0cnVjdCBjZXBoX29zZF9yZXF1ZXN0ICpyZXEs
CiBzdGF0aWMgdm9pZCBlbmNvZGVfcmVxdWVzdF9maW5pc2goc3RydWN0IGNlcGhfbXNnICptc2cp
CiB7CiAJdm9pZCAqcCA9IG1zZy0+ZnJvbnQuaW92X2Jhc2U7CisJdm9pZCAqY29uc3QgcGFydGlh
bF9lbmQgPSBwICsgbXNnLT5mcm9udC5pb3ZfbGVuOwogCXZvaWQgKmNvbnN0IGVuZCA9IHAgKyBt
c2ctPmZyb250X2FsbG9jX2xlbjsKIAogCWlmIChDRVBIX0hBVkVfRkVBVFVSRShtc2ctPmNvbi0+
cGVlcl9mZWF0dXJlcywgUkVTRU5EX09OX1NQTElUKSkgewogCQkvKiBsdW1pbm91cyBPU0QgLS0g
ZW5jb2RlIGZlYXR1cmVzIGFuZCBiZSBkb25lICovCi0JCXAgPSBlbmQgLSA4OworCQlwID0gcGFy
dGlhbF9lbmQ7CiAJCWNlcGhfZW5jb2RlXzY0KCZwLCBtc2ctPmNvbi0+cGVlcl9mZWF0dXJlcyk7
CiAJfSBlbHNlIHsKIAkJc3RydWN0IHsKQEAgLTE5ODQsNyArMTk4Nyw3IEBAIHN0YXRpYyB2b2lk
IGVuY29kZV9yZXF1ZXN0X2ZpbmlzaChzdHJ1Y3QgY2VwaF9tc2cgKm1zZykKIAkJb2lkX2xlbiA9
IHAgLSBvaWQ7CiAKIAkJdGFpbCA9IHA7Ci0JCXRhaWxfbGVuID0gKGVuZCAtIHApIC0gODsKKwkJ
dGFpbF9sZW4gPSBwYXJ0aWFsX2VuZCAtIHA7CiAKIAkJcCA9IG1zZy0+ZnJvbnQuaW92X2Jhc2U7
CiAJCWNlcGhfZW5jb2RlX2NvcHkoJnAsICZoZWFkLmNsaWVudF9pbmMsIHNpemVvZihoZWFkLmNs
aWVudF9pbmMpKTsKLS0gCjIuNC4zCgo=
--001a1144109609a869055523eea2--
