From: star fan <jfanix@gmail.com>
Subject: Ask help for boost::statechart in PG
Date: Sat, 30 Aug 2014 20:18:51 +0800
Message-ID: <CAOdVJi2e2cBOwRk8TS4Te2eZ1NO2hw26zL6M3Mq94pv60Z9vWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:56309 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaH3MSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Aug 2014 08:18:53 -0400
Received: by mail-wi0-f196.google.com with SMTP id ho1so1839891wib.3
        for <ceph-devel@vger.kernel.org>; Sat, 30 Aug 2014 05:18:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

I ask the question because I am not good at  boost::statechart and I
can't get answer from other way.

To help me to good understand the PG statechart, I hope someone answer
below questions:
In Initial state,
1.  why there is not react function for custom_reaction< NullEvt >
2. why there is not custom_reaction definition about
boost::statechart::result react(const MNotifyRec&);

Regards
Vincent
