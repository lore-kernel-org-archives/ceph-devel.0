From: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Subject: RGW GetObj interfaces
Date: Thu, 19 Feb 2015 13:22:22 +0000
Message-ID: <68A06213B74F1742A2C48216AE1BB6B808754433@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:26251
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932495AbbBSNzT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Feb 2015 08:55:19 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: "yehuda@redhat.com" <yehuda@redhat.com>

Was tracing the 'get object' path(s) in RGW and found that the interfaces have changed quite a bit between Giant and Master. Particularly in Giant, I reckon there is a potential leak of the 'handle' (which is the object state in question)

<snip>

  ret = store->prepare_get_obj(s->obj_ctx, obj, &new_ofs, &new_end, &attrs, mod_ptr,
                               unmod_ptr, &lastmod, if_match, if_nomatch, &total_len, &s->obj_size, NULL, &handle, &s->err);
  if (ret < 0)
    goto done_err;

  attr_iter = attrs.find(RGW_ATTR_USER_MANIFEST);
  if (attr_iter != attrs.end()) {
    ret = handle_user_manifest(attr_iter->second.c_str());
    if (ret < 0) {
      ldout(s->cct, 0) << "ERROR: failed to handle user manifest ret=" << ret << dendl;
    }
    return;               <----------- One should free the handle via finish_get_obj()
  }

<\snip>

And also, I see 'send_response_data()' being issued even for error paths, which need not be true always. I understand the pull request for rgw versioning #3526 has revamped this piece of code, but Giant has the inaccuracies(if true) I pointed above.

Let me know if my understanding is correct, I will have couple of pull requests in pipeline for the same.

Thanks,
-Pavan.

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

