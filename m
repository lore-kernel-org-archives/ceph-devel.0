From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: jewel debian init.d script not working (since commit
 65963739cd6815b8008282c8f64cd64365662e60)
Date: Sat, 23 Apr 2016 18:23:41 +0200 (CEST)
Message-ID: <1594089701.399470298.1461428621221.JavaMail.zimbra@oxygem.tv>
References: <1762230726.399345620.1461427712715.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:44985 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcDWQXn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Apr 2016 12:23:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 0FCFC4CD14A81
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 18:23:42 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zLCrJ99Z5yEk for <ceph-devel@vger.kernel.org>;
	Sat, 23 Apr 2016 18:23:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id D96304CD78BCC
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 18:23:41 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9mPMDcopqhXA for <ceph-devel@vger.kernel.org>;
	Sat, 23 Apr 2016 18:23:41 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id B4D4A4CD14A81
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 18:23:41 +0200 (CEST)
In-Reply-To: <1762230726.399345620.1461427712715.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

the bash variables tests need to be quoted

-if [ -n $CEPH_BIN ] && [ -n $CEPH_ROOT ] && [ -n $CEPH_BUILD_DIR ]; th=
en

+if [ -n "$CEPH_BIN" ] && [ -n "$CEPH_ROOT" ] && [ -n "$CEPH_BUILD_DIR"=
 ]; then


or It's always true if the variables are not defined.



----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Samedi 23 Avril 2016 18:08:32
Objet: jewel debian init.d script not working (since commit 65963739cd6=
815b8008282c8f64cd64365662e60)

Hi,=20

since this commit=20
https://github.com/ceph/ceph/commit/65963739cd6815b8008282c8f64cd643656=
62e60=20



if [ -n $CEPH_BIN ] && [ -n $CEPH_ROOT ] && [ -n $CEPH_BUILD_DIR ]; the=
n=20
#need second look at all variables, especially ETCDIR=20
BINDIR=3D$CEPH_BIN=20
SBINDIR=3D$CEPH_ROOT/src=20
ETCDIR=3D$CEPH_BUILD_DIR=20
LIBEXECDIR=3D$CEPH_ROOT/src=20
SYSTEMD_RUN=3D""=20
ASSUME_DEV=3D1=20
fi=20



debian init.d script is not working anymore=20


=46rom where are comming these $CEPH_BIN, $CEPH_ROOT, $CEPH_BUILD_DIR ?=
=20

It's always empty when we call init.d script=20

>>test -f $LIBEXECDIR/ceph_common.sh || exit 0=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
