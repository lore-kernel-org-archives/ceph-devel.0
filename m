From: Sage Weil <sage@newdream.net>
Subject: Re: =?Big5?Q?Re=3A_=B5=AA=CE=60=3A_The_installation=3A_When_we_start_Ceph=2C_th?=
 =?Big5?Q?e_system_stops_running=2E?=
Date: Wed, 6 Apr 2011 08:58:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104060857210.18205@cobra.newdream.net>
References: <AANLkTinV864-rE6HERpmL-DBtx_eqp2DNRGqiZWatWtA@mail.gmail.com>
 <000001cbf047$332925b0$997b7110$@com> <BANLkTi=cGkuCS_X_PLL8k_JNPZNxZf7-bA@mail.gmail.com>
 <BANLkTimGBT6dVz9cS4YAzLLGvpvvt8sqWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37292 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430Ab1DFPy5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Apr 2011 11:54:57 -0400
In-Reply-To: <BANLkTimGBT6dVz9cS4YAzLLGvpvvt8sqWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "doki74216@gmail.com" <doki74216@gmail.com>
Cc: Yuki <chengmao2010@gmail.com>, ceph-devel@vger.kernel.org, henry.cy.chang@gmail.com, tommi.virtanen@dreamhost.com

On Wed, 6 Apr 2011, doki74216@gmail.com wrote:
>  Thanks for your help!!
>  But I have the other question:
>  If  I do "/etc/init.d/ceph -a stop "
>  the system doesn't stop all the deamon which include cmon and cosd.
>  Therefore I have to enter each host to close the deamon seperatly.
>  Finally, there is no deamon running in the system.
>  I want to know why we cannot stop the deamon by "/etc/init.d/ceph -a stop "???
>  What's wrong with my system??
> [...]
>         host = Ceph1

My guess is it is doing a case-sensitive comparison of Ceph1 and 
`hostname` output.  Try switching to lower case and see if that fixes it.

sage
