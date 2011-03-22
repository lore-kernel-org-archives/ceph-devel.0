From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Fwd: Monitoring osd
Date: Tue, 22 Mar 2011 14:42:41 +0100
Message-ID: <1300801361.10707.2.camel@Nokia-N900-02-8>
References: <AANLkTi=yz00Di-ANfGmA9+6fGHNEtiFAVUYRJAPOqRVB@mail.gmail.com>
	  <AANLkTimOQNGnkqOw-RWgHXgaWYq9DD8OKNO_FhJt3bAv@mail.gmail.com>
Reply-To: Wido den Hollander <wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:48806 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab1CVNms (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2011 09:42:48 -0400
In-Reply-To: <AANLkTimOQNGnkqOw-RWgHXgaWYq9DD8OKNO_FhJt3bAv@mail.gmail.com>
Content-ID: <1300801360.10707.1.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>, ceph-devel@vger.kernel.org, sage@newdream.net

Hi,
----- Original message -----
> Hi
> How to monitor osds or mds failures to take necessary actions?
> 

There is a 'ceph health' command which tells you the cluster health.

You could script around it, there are no nagios or zabbix plugins that I know about.

Wido
