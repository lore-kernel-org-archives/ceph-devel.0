From: Sage Weil <sage@inktank.com>
Subject: Re: rbd image association
Date: Mon, 3 Jun 2013 07:49:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306030748240.18537@cobra.newdream.net>
References: <51AC3D1E.2000800@gmail.com> <20130603070836.GA2422@nix.wogri.at> <51AC42FC.1040703@gmail.com> <51AC4717.7010304@42on.com> <51AC4980.4010000@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37152 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab3FCOtZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 10:49:25 -0400
In-Reply-To: <51AC4980.4010000@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: Wido den Hollander <wido@42on.com>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On Mon, 3 Jun 2013, Roman Alekseev wrote:
> On 03.06.2013 11:34, Wido den Hollander wrote:
> > udev takes car
> 
> Do you mean we need to create some rules in /etc/udev/rules.d/ directory and
> after running rbd -p pool map image my image will be mapped with appropriate
> device?

The ceph package installs a udev rules file in that directory; you 
shouldn't have to do anything other than the 'rbd map ..' command.  If it 
is not already present, there must be something wrong with the package on 
the platform you are using.  What OS is it?

> 
> If so, could you please provide me with the commands which should be presented
> in that file?
> 
> Thanks
> 
> -- 
> Kind regards,
> 
> R. Alekseev
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
