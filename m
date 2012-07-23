From: "Pascal de Bruijn | Unilogic B.V." <p.debruijn@unilogic.nl>
Subject: Ceph status Icinga/NAGIOS plugin
Date: Mon, 23 Jul 2012 14:40:36 +0200
Message-ID: <1343047236.9475.10.camel@clawhammer>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:39980 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752675Ab2GWMkl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Jul 2012 08:40:41 -0400
Received: from router (router.unilogic.nl [62.133.193.82])
	by mail.unilogicnetworks.net (Postfix) with ESMTP id A60474A0F6
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 14:40:39 +0200 (CEST)
Received: from mail.unilogic.local (mail.unilogic.nl [10.0.11.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by router (Postfix) with ESMTP id 81F536E787
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 14:40:33 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.unilogic.local
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
	for ceph-devel@vger.kernel.org;
	Mon, 23 Jul 2012 14:40:36 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

We use Icinga to monitor most of our infrastructure, and thus wanted to
monitor our Ceph cluster using that as well.

We created a simple check_ceph_status script which is executed locally
on all of our MONs/MDSes via NRPE.

It seems there are other efforts in this area as well, but we needed
something that was fairly simple and would work straight away.

What the script does is
 - execute ceph status
 - look for the first line with HEALTH_ on it
 - remove HEALTH_ and everything that precedes it from that line
 - replace WARN and ERR with WARNING and ERROR respectively
 - Depending on the first few remaining characters on the line we 
   generate an exit code (OK #0 / WARNING #1 / ERROR #2)
 - If all else fails exit with a UNKNOWN exit code (#3)

The actual script is attached below. Feel free to do with it whatever
you like.

Regards,
Pascal de Bruijn
Unilogic B.V.

========================================================================

#!/bin/bash
#
# Ceph status Icinga plugin
#
# Copyright (c) 2012 Unilogic B.V.
#                    Pascal de Bruijn
#
# This script isn't /bin/dash compatible as it
# uses /bin/bash specific syntax for clarity
#

CEPH_STATUS=$(ceph status | grep 'HEALTH_' | head -n 1 | sed 's#.*HEALTH_##' | sed 's#WARN#WARNING#' | sed 's#ERR#ERROR#')

echo "${CEPH_STATUS}"

if [[ "${CEPH_STATUS:0:2}" == "OK" ]]; then
  exit 0
fi

if [[ "${CEPH_STATUS:0:7}" == "WARNING" ]]; then
  exit 1
fi

if [[ "${CEPH_STATUS:0:5}" == "ERROR" ]]; then
  exit 2
fi

# if no OK, WARNING or ERROR status has been detected we exit with an UNKNOWN status code
exit 3



