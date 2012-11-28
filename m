From: Caleb Miles <caleb.miles@inktank.com>
Subject: Re: chooseleaf_descend_once
Date: Wed, 28 Nov 2012 11:16:06 -0500
Message-ID: <CA+zLgM2nD2b0mAG219r0KXZD+U=AbcoCN3-iPzuwzJ_jG5jJaA@mail.gmail.com>
References: <50B4255B.10509@inktank.com>
	<50B50662.2040002@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:39569 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab2K1QQJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 11:16:09 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so5328977eaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 08:16:08 -0800 (PST)
In-Reply-To: <50B50662.2040002@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Hey Jim,

Running the third test with tunable chooseleaf_descend_once 0 with no
devices marked out yields the following result

(999.82733333333397, 0.48667056652539997)

so chi squared value is 999 with a corresponding p value of 0.487 so
that the placement distribution seems to be drawn from the uniform
distribution as desired.

Caleb
