From: chen kael <chenji.bupt@gmail.com>
Subject: when create a new pool, Does straw2 applies in crushmap by default?
Date: Wed, 19 Aug 2015 14:18:23 +0800
Message-ID: <CAA-rZjb703OESbaZW=8z_D2h3ePb-hFo3LYQrX_7CsDLpi6USQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37578 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbHSGSY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 02:18:24 -0400
Received: by wibhh20 with SMTP id hh20so126795597wib.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2015 23:18:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

When setting up a new enviroment, How can I  make all pools created
use straw2 other than straw by default?
Such as ./vstart.sh -l -n -x ,I hope all pools use straw2 ,no need
change bucket type by myself
