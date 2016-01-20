From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Nodown/Noout by OSD_ID?
Date: Wed, 20 Jan 2016 13:42:03 +0800
Message-ID: <CAEYCsVLFUYAeKT_2bxyA1DpC5K5yzS6JHM=eJ=4WuGpjdypTnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33329 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcATFmF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 00:42:05 -0500
Received: by mail-yk0-f172.google.com with SMTP id k129so652517907yke.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jan 2016 21:42:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

     In many case we need to tag some OSD with NODOWN/NOOUT/NOUP/NOIN
tag, but we dont want it cluster wise as these tag may stop other OSDs
doing self-healthing.As a an example when an recovered OSD need to
catch up with the OSDMap, to prevent flipping we set
NODOWN/NOOUT/NOUP, but if other OSD failed by disk error, the failure
will be hidden and we are in the risk of lossing the data.

     Is that reasonable to have these flag work in OSD granularity?
say ceph osd nodown osd.xxx?
     Quick look at the code seems NODOWN/NOUP is easier as we could
have new status bits in OSDMap
     /* status bits */
#define CEPH_OSD_EXISTS  (1<<0)
#define CEPH_OSD_UP      (1<<1)
#define CEPH_OSD_AUTOOUT (1<<2)  /* osd was automatically marked out */
#define CEPH_OSD_NEW     (1<<3)  /* osd is new, never marked in */

#define CEPH_OSD_NOUP     (1<<4)  /* osd cannot be marked in */
#define CEPH_OSD_NODOWN     (1<<5)  /* osd cannot be marked out */

     But for NOIN/NOOUT seems a bit struggle as IN/OUT depends on
weight? Any suggestion?


Xiaoxi
