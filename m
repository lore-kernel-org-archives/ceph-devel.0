From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Asserts while running test/erasure-code/test-erasure-eio.sh
Date: Sun, 17 Jan 2016 17:32:09 +0100
Message-ID: <569BC209.2000600@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43883 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbcAQQcl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Jan 2016 11:32:41 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 8AE4915340A
	for <ceph-devel@vger.kernel.org>; Sun, 17 Jan 2016 17:32:40 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 9DDEB153401
	for <ceph-devel@vger.kernel.org>; Sun, 17 Jan 2016 17:32:08 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


When I run the above script I get asserts:

osd/ECBackend.cc: 201: FAILED assert(res.errors.empty())

Which is in this code:
struct OnRecoveryReadComplete :
  public GenContext<pair<RecoveryMessages*, ECBackend::read_result_t& > &> {
  ECBackend *pg;
  hobject_t hoid;
  set<int> want;
  OnRecoveryReadComplete(ECBackend *pg, const hobject_t &hoid)
    : pg(pg), hoid(hoid) {}
  void finish(pair<RecoveryMessages *, ECBackend::read_result_t &> &in) {
    ECBackend::read_result_t &res = in.second;
    // FIXME???
    assert(res.r == 0);
    assert(res.errors.empty());
    assert(res.returned.size() == 1);
    pg->handle_recovery_read_complete(
      hoid,
      res.returned.back(),
      res.attrs,
      in.first);
  }
};

Now the //FIXME remark suggests that the code could be not oke.
And/or the asserts are too strong.
Any hints, suggestions or questions to fix this.

--WjW



