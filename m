From: andrew@ningd5.research.att.com (Andrew Hume)
Subject: changes to rados command
Date: Thu, 07 Mar 2013 14:25:21 -0500
Message-ID: <20130307192522.0F7C7EAF31@ningd5.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from H-135-207-249-235.research.att.com ([135.207.249.235]:41957
	"EHLO ningd5.research.att.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932366Ab3CGTd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 14:33:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


in order to make the rados command more useful in scripts,
i'd like to make a change, specifically change to

rados -p pool getomapval obj key [fmt]

where fmt is an optional formatting parameter.
i've implemented 'str' which will print the value as an unadorned string.

what is the process for doing this?

andrew hume
