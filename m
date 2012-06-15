From: Florian Haas <florian@hastexo.com>
Subject: Building documentation offline?
Date: Fri, 15 Jun 2012 06:00:51 +0200
Message-ID: <4FDAB373.1060503@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52737 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab2FOEA5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 00:00:57 -0400
Received: by obbtb18 with SMTP id tb18so3386126obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jun 2012 21:00:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi everyone,

it occurred to me this afternoon that admin/build-doc unconditionally
tries to fetch some updates from GitHub, which breaks building docs when
you don't have a network connection. Would there be any reasonably
simple way to make it support offline build, provided the various pip
bits have previously been downloaded and installed?

Cheers,
Florian
