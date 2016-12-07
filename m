From: Sage Weil <sage@newdream.net>
Subject: Re: [SUGGESTION]Should we provide a method to get git's branch name
 and commit tag?
Date: Wed, 7 Dec 2016 14:31:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612071431140.22485@piezo.novalocal>
References: <CACKY0b8Y1JFqu-qD-XXUx9ZtLitfFuEaSqamEGK4fD=SspoziA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-751237113-1481121117=:22485"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51761 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbcLGOb7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 09:31:59 -0500
In-Reply-To: <CACKY0b8Y1JFqu-qD-XXUx9ZtLitfFuEaSqamEGK4fD=SspoziA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?wfWzqQ==?= <liuchang0812@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-751237113-1481121117=:22485
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Dec 2016, 刘畅 wrote:
> hi, all
> 
> For example, we could register a command "build info" to
> CephContext::_admin_sock. I would like to implement it if it's useful
> and necessary.

The 'version' command will give you the commit.  It doesn't show the 
branch name, though.

sage
--8323329-751237113-1481121117=:22485--
