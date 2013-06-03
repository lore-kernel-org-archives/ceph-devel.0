From: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>
Subject: Re: rbd image association
Date: Mon, 3 Jun 2013 09:36:04 +0200
Message-ID: <20130603073603.GB2422@nix.wogri.at>
References: <51AC3D1E.2000800@gmail.com>
 <20130603070836.GA2422@nix.wogri.at>
 <51AC42FC.1040703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.wogri.at ([85.233.97.252]:33262 "EHLO mail.wogri.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab3FCHnp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 03:43:45 -0400
Content-Disposition: inline
In-Reply-To: <51AC42FC.1040703@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jun 03, 2013 at 11:17:16AM +0400, Roman Alekseev wrote:
> Dear Wolfgang,
> 
> I was trying to use the command ln -s /dev/rbd1 image1 but it
> creates wrong symlink. Most likely there is more specific command to
> symlink the image and device correctly.

No, you should not have to do anything manually. I was saying udev should create the symlink for you upon image mapping. If it doesn't, check you udev configuration. It does this for me on ubuntu server. 
 
> Thanks.

Wolfgang

-- 
http://www.wogri.com
