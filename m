From: Casey Bodley <cbodley@redhat.com>
Subject: multi-site rgw and the period push/pull api
Date: Thu, 3 Sep 2015 17:09:37 -0400 (EDT)
Message-ID: <1624232893.12469438.1441314577271.JavaMail.zimbra@redhat.com>
References: <1131886463.12452865.1441312989166.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:34771 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757511AbbICVJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 17:09:37 -0400
In-Reply-To: <1131886463.12452865.1441312989166.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, ceph-devel@vger.kernel.org

Hi Orit and Yehuda,

A couple questions came up today while I was fleshing out the /admin/realm handler:

I found a RGWOp_Period_Get() and _Post() in rgw_rest_config.cc that do pretty much what we want for push and pull.  Is this /admin/config handler temporary, or should we share these ops between the /admin/config and /admin/realm handlers?

I also asked Yehuda for clarification on the push op (POST /admin/realm/period):

(04:09:59 PM) cbodley: i'm confused, because the title says "Request children to fetch period", but under Input: it includes a json representation of the period
(04:10:29 PM) cbodley: so should the POST include the data, or should the handler send a GET request to fetch it?
(04:11:57 PM) yehudasa_: cbodley, great question.. let me take a look
(04:14:21 PM) cbodley: i guess it depends on how we do authentication? we don't want to accept a POST from any random endpoint, and overwrite our map. so sending a GET to a known party sounds safer in that respect
(04:14:30 PM) yehudasa_: cbodley, I think it should include the period data
(04:15:20 PM) yehudasa_: we should only allow authenticated system users to be able to send it to us

So my followup question is, should we get rid of the period_id and epoch parameters for POST, since the json-encoded period will contain those already?

Thanks,
Casey
