From: Bryant Ng <bryantng@gmail.com>
Subject: Re: Crush and Monitor questions
Date: Tue, 11 Dec 2012 17:15:36 -0800
Message-ID: <ka8lrn$o20$1@ger.gmane.org>
References: <ka84oo$sa3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60863 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab2LLBQB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 20:16:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Tiavj-00040E-1Q
	for ceph-devel@vger.kernel.org; Wed, 12 Dec 2012 02:16:11 +0100
Received: from 50-76-54-11-ip-static.hfc.comcastbusiness.net ([50.76.54.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 02:16:10 +0100
Received: from bryantng by 50-76-54-11-ip-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 02:16:10 +0100
In-Reply-To: <ka84oo$sa3$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sorry, I misread the Hardware Configuration section of the Ceph 
documentation.  I thought one of the Dell's was a configuration for the 
monitors but both of the Dell R510 and R515 are OSD configuration.

I had another question on the monitors though.  What kind of load 
(requests/second) can a monitor node handle?  My understanding is that 
it just returns the cluster map to the client requesting it?  The 
documentation mentions 3 to 5 monitors in a ceph cluster but what is the 
request rate expected on each of these monitors?

thanks.
Bryant


Bryant Ng wrote:
> Hi,
>
> I'm pretty new to Ceph and am just learning about it.
>
> Where are the CRUSH maps stored in Ceph? In the documentation I see you
> use the 'crushtool' to compile and decompile the crush map.  I
> understand that if a single monitor comes online, it can talk to the
> other existing monitors to get the cluster map but how does it work on
> initial startup?  Or if the entire Ceph clusters goes down b/c of power
> failure or something.
>
> What is the recommended hardware configuration for monitors?  In the
> Hardware Recommendation page it says "A monitor requires approximately
> 10GB of storage space per daemon instance."  per daemon instance is
> talking about the monitor daemon, not the osd daemons?
>
> Also further down on that page, it list some hardware examples where it
> mentions a ligher configuration for monitors.  I am assuming that is the
> Dell PE R510 which contains 8 x 2 TB drives.  Why does the monitor need
> so much space if it's "10GB of storage space per daemon instance".
>
> -Bryant
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


