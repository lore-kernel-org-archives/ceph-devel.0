From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: jewel debian init.d script not working (since commit
 65963739cd6815b8008282c8f64cd64365662e60)
Date: Sat, 23 Apr 2016 18:08:32 +0200 (CEST)
Message-ID: <1762230726.399345620.1461427712715.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:43450 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcDWQIf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Apr 2016 12:08:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 6FAD94CF34A7B
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 18:08:33 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KfrHNGCfCaam for <ceph-devel@vger.kernel.org>;
	Sat, 23 Apr 2016 18:08:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 3F6534CF34A7C
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 18:08:33 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dySJwezBJaVR for <ceph-devel@vger.kernel.org>;
	Sat, 23 Apr 2016 18:08:33 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id 13F174CF34A7B
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 18:08:33 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

since this commit
https://github.com/ceph/ceph/commit/65963739cd6815b8008282c8f64cd64365662e60



if [ -n $CEPH_BIN ] && [ -n $CEPH_ROOT ] && [ -n $CEPH_BUILD_DIR ]; then
  #need second look at all variables, especially ETCDIR
  BINDIR=$CEPH_BIN
  SBINDIR=$CEPH_ROOT/src
  ETCDIR=$CEPH_BUILD_DIR
  LIBEXECDIR=$CEPH_ROOT/src
  SYSTEMD_RUN=""
  ASSUME_DEV=1
fi



debian init.d script is not working anymore


From where are comming these $CEPH_BIN, $CEPH_ROOT, $CEPH_BUILD_DIR  ?

It's always empty when we call init.d script

>>test -f $LIBEXECDIR/ceph_common.sh || exit 0

