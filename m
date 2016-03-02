From: Ilya Dryomov <idryomov@gmail.com>
Subject: Issues with exclusive-lock code on testing
Date: Wed, 2 Mar 2016 12:26:10 +0100
Message-ID: <CAOi1vP-+LaGx5q4_MkW7w0gShDzA7fEgAFmJOONvDxL3Owjf5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a114b02661f1843052d0f267f
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34594 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbcCBL0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 06:26:12 -0500
Received: by mail-wm0-f47.google.com with SMTP id p65so75332072wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Mar 2016 03:26:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Doug Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--001a114b02661f1843052d0f267f
Content-Type: text/plain; charset=UTF-8

Hi Doug,

The cause of that memory corruption is a premature (duplicate, too)
call to rbd_obj_request_complete() in the !object-map DELETE case.
You've got:

    <dispatch>
    rbd_osd_req_callback
      rbd_osd_delete_callback
        rbd_osd_discard_callback
        rbd_obj_request_complete
          <complete obj_request->completion>
                                                <waiter is woken up>
                                                ...
                                                rbd_obj_request_put
                                                <obj_request is gone>
    <do more things with obj_request> <- !!!
    rbd_obj_request_complete
      <complete obj_request->completion>

I also spotted two memory leaks on the NOTIFY_COMPLETE path in
__do_event().  The event one is trivial, the page vector one I have
a question about.  The data item is allocated in alloc_msg() and the
actual buffer is then passed into __do_event() and eventually into
rbd_send_async_notify(), but not further up the stack.  Is anything
going to use it?  If not, we should remove it entirely.

Another thing that caught my eye is your diff adds a bunch of
ceph_get_snap_context() calls on header.snapc with no corresponding
puts.  My understanding is the ones around rbd_image_request_fill() are
there to workaround the fact that rbd_queue_workfn() isn't used, but
the one in rbd_obj_delete_sync() is immediately followed by
ceph_osdc_build_request() which bumps snapc and so is almost certainly
a leak.

The attached patch fixes the use-after-free and plugs those leaks.
With it applied your test loop runs fine for me - no crashes or out of
memory problems.

Thanks,

                Ilya

--001a114b02661f1843052d0f267f
Content-Type: text/plain; charset=US-ASCII; name="doug-testing.diff"
Content-Disposition: attachment; filename="doug-testing.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ilar62ro0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svcmJkLmMgYi9kcml2ZXJzL2Jsb2NrL3JiZC5jCmlu
ZGV4IDkyYzM1NDI1NjA1NS4uYzAxOThiNmNhNjA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2Nr
L3JiZC5jCisrKyBiL2RyaXZlcnMvYmxvY2svcmJkLmMKQEAgLTE5MzAsMTQgKzE5MzAsMTQgQEAg
c3RhdGljIHZvaWQgcmJkX29zZF9kZWxldGVfY2FsbGJhY2soc3RydWN0IHJiZF9vYmpfcmVxdWVz
dCAqb2JqX3JlcXVlc3QpCiAJdTggY3VycmVudF9zdGF0ZTsKIAogCWlmICghb2JqX3JlcXVlc3Qt
PmltZ19yZXF1ZXN0KSB7Ci0JCXJiZF9vc2RfY29tcGxldGVfZGVsZXRlKG9ial9yZXF1ZXN0KTsK
KwkJcmJkX29zZF9kaXNjYXJkX2NhbGxiYWNrKG9ial9yZXF1ZXN0KTsKIAkJcmV0dXJuOwogCX0K
IAogCXJiZF9kZXYgPSBvYmpfcmVxdWVzdC0+aW1nX3JlcXVlc3QtPnJiZF9kZXY7CiAKIAlpZiAo
IXJiZF91c2Vfb2JqZWN0X21hcChyYmRfZGV2KSkgewotCQlyYmRfb3NkX2NvbXBsZXRlX2RlbGV0
ZShvYmpfcmVxdWVzdCk7CisJCXJiZF9vc2RfZGlzY2FyZF9jYWxsYmFjayhvYmpfcmVxdWVzdCk7
CiAJCXJldHVybjsKIAl9CiAKQEAgLTM2MzIsMTAgKzM2MzIsMTMgQEAgc3RhdGljIGludCByYmRf
c2VuZF9hc3luY19ub3RpZnkoc3RydWN0IHJiZF9kZXZpY2UgKnJiZF9kZXYsCiAJfQogCiAJY29t
cGxldGVkID0gY2VwaF9vc2RjX3dhaXRfZXZlbnQob3NkYywgbm90aWZ5X2V2ZW50KTsKLQlpZiAo
IWNvbXBsZXRlZCkKKwlpZiAoIWNvbXBsZXRlZCkgewogCQlyZXQgPSAtRVRJTUVET1VUOwotCWVs
c2UKKwl9IGVsc2UgewogCQlyZXQgPSBub3RpZnlfZXZlbnQtPm5vdGlmeS5yZXR1cm5fY29kZTsK
KwkJY2VwaF9yZWxlYXNlX3BhZ2VfdmVjdG9yKG5vdGlmeV9ldmVudC0+bm90aWZ5Lm5vdGlmeV9k
YXRhLAorCQkgICAgY2FsY19wYWdlc19mb3IoMCwgbm90aWZ5X2V2ZW50LT5ub3RpZnkubm90aWZ5
X2RhdGFfbGVuKSk7CisJfQogCiBjYW5jZWxfZXZlbnQ6CiAJY2VwaF9vc2RjX2NhbmNlbF9ldmVu
dChub3RpZnlfZXZlbnQpOwpAQCAtNDgyOCw3ICs0ODMxLDYgQEAgc3RhdGljIGludCByYmRfb2Jq
X2RlbGV0ZV9zeW5jKHN0cnVjdCByYmRfZGV2aWNlICpyYmRfZGV2LAogCiAJLy9vYmpfcmVxdWVz
dC0+b3NkX3JlcS0+cl9wcml2ID0gb2JqX3JlcXVlc3Q7CiAKLQljZXBoX2dldF9zbmFwX2NvbnRl
eHQocmJkX2Rldi0+aGVhZGVyLnNuYXBjKTsKIAlvc2RfcmVxX29wX2luaXQob2JqX3JlcXVlc3Qt
Pm9zZF9yZXEsIDAsIENFUEhfT1NEX09QX0RFTEVURSwgMCk7CiAJcmJkX29zZF9yZXFfZm9ybWF0
X3NuYXBfd3JpdGUob2JqX3JlcXVlc3QsIHJiZF9kZXYtPmhlYWRlci5zbmFwYyk7CiAKZGlmZiAt
LWdpdCBhL25ldC9jZXBoL29zZF9jbGllbnQuYyBiL25ldC9jZXBoL29zZF9jbGllbnQuYwppbmRl
eCA4MzE2YTMwNGFmNjMuLjEyODQxYzVhMDljNyAxMDA2NDQKLS0tIGEvbmV0L2NlcGgvb3NkX2Ns
aWVudC5jCisrKyBiL25ldC9jZXBoL29zZF9jbGllbnQuYwpAQCAtMjk0Miw2ICsyOTQyLDcgQEAg
c3RhdGljIHZvaWQgX19kb19ldmVudChzdHJ1Y3QgY2VwaF9vc2RfY2xpZW50ICpvc2RjLCB1OCBv
cGNvZGUsCiAJCQkJCWV2ZW50LT5vc2RfcmVxID0gTlVMTDsKIAkJCQl9CiAJCQkJY29tcGxldGVf
YWxsKCZldmVudC0+bm90aWZ5LmNvbXBsZXRlKTsKKwkJCQljZXBoX29zZGNfcHV0X2V2ZW50KGV2
ZW50KTsKIAkJCX0KIAkJCWJyZWFrOwogCQlkZWZhdWx0Ogo=
--001a114b02661f1843052d0f267f--
