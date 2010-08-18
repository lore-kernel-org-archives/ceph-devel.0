From: Thomas Mueller <thomas@chaschperli.ch>
Subject: rgw/rgw_rest.cc: 1 new compler warning
Date: Wed, 18 Aug 2010 15:56:39 +0000 (UTC)
Message-ID: <i4gvrn$6h8$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38361 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab0HRQAL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Aug 2010 12:00:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Oll3c-0004Mf-B7
	for ceph-devel@vger.kernel.org; Wed, 18 Aug 2010 18:00:04 +0200
Received: from 46-127-100-83.dclient.hispeed.ch ([46.127.100.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Aug 2010 18:00:04 +0200
Received: from thomas by 46-127-100-83.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 18 Aug 2010 18:00:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

I see one new comiler warning:


g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D=
_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT rgw_common.o -MD -MP -MF=
 .deps/rgw_common.Tpo -c -o rgw_common.o `test -f 'rgw/rgw_common.cc' |=
| echo './'`rgw/rgw_common.cc
rgw/rgw_rest.cc: In function =E2=80=98void dump_content_length(req_stat=
e*, size_t)=E2=80=99:
 rgw/rgw_rest.cc:87: warning: format =E2=80=98%llu=E2=80=99 expects typ=
e =E2=80=98long long unsigned int=E2=80=99, but argument 4 has type =E2=
=80=98size_t=E2=80=99
 rgw/rgw_rest.cc:87: warning: format =E2=80=98%llu=E2=80=99 expects typ=
e =E2=80=98long long unsigned int=E2=80=99, but argument 4 has type =E2=
=80=98size_t=E2=80=99

- Thomas

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
