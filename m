From: Ugis <ugis22@gmail.com>
Subject: status monitoring options for ceph cluster
Date: Wed, 2 Jan 2013 17:05:32 +0200
Message-ID: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33590 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab3ABPFd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 10:05:33 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so16871469iea.16
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 07:05:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I am planning to set up monitoring of ceph cluster relying on output
of commands:

#ceph health
#ceph -s

The need is to retrieve certain values, for example %degraded;
proportion "X GB / Y GB avail" to calculate available space%. I plan
to graph those values via zabbix and set up triggers for certain
tresholds.
May be somebody already has written shell parser for getting values
from output of these commands?

Probably this ir wider question - what is the intended approach for
ceph cluster monitoring? What do you guys use?

BR,
Ugis
