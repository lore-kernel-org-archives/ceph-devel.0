From: Sage Weil <sage@inktank.com>
Subject: Re: status monitoring options for ceph cluster
Date: Thu, 3 Jan 2013 08:51:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301030849080.5264@cobra.newdream.net>
References: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com> <50E44D79.6070809@widodh.nl> <50E45909.4080907@inktank.com> <50E4619C.6070300@conversis.de> <50E4BC90.4030407@inktank.com> <50E4BD4B.2040005@inktank.com>
 <50E55CDE.1030104@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab3ACQvD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 11:51:03 -0500
In-Reply-To: <50E55CDE.1030104@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Dan Mick <dan.mick@inktank.com>, Dennis Jacobfeuerborn <dennisml@conversis.de>, Joao Eduardo Luis <joao.luis@inktank.com>, Ugis <ugis22@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 3 Jan 2013, Wido den Hollander wrote:
> On 01/03/2013 12:05 AM, Dan Mick wrote:
> > (and of course it makes sense to build those on libraries that could
> > serve other access methods)
> 
> I'd prefer a library :-) This way you can build your own binaries, bindings
> for languages like Python, PHP and Java.
> 
> The binaries could just link against the library and output information in any
> way we want for Zabbix, Nagios, Icinga, etc.

A library is coming very soon, and shortly after that a REST interface 
that wraps it.

Dennis, Ugis:

More generally, the 'ceph report' command will give you a JSON dump of 
theh current cluster status.  You can get less detail from 'ceph health 
[detail]', which will also have a JSON option shortly.

You may also be interested in the admin socket, which lets you query 
individaul running daemons (instead of the monitor):

 ceph --admin-daemon /var/run/ceph/ceph-osd.123.asok help

sage

> 
> Wido
> 
> > 
> > On 01/02/2013 03:02 PM, Dan Mick wrote:
> > > There are plans being discussed for RESTful interfaces for configuration
> > > and monitoring; no timetable yet but it's definitely on our radar, and
> > > we'll discuss design etc. here when it starts happening; anyone wanting
> > > to participate is of course welcome.
> > > 
> > > On 01/02/2013 08:34 AM, Dennis Jacobfeuerborn wrote:
> > > > On 01/02/2013 04:58 PM, Joao Eduardo Luis wrote:
> > > > > On 01/02/2013 03:08 PM, Wido den Hollander wrote:
> > > > > > On 01/02/2013 04:05 PM, Ugis wrote:
> > > > > > > Hi all,
> > > > > > > 
> > > > > > > I am planning to set up monitoring of ceph cluster relying on
> > > > > > > output
> > > > > > > of commands:
> > > > > > > 
> > > > > > > #ceph health
> > > > > > > #ceph -s
> > > > > > > 
> > > > > > > The need is to retrieve certain values, for example %degraded;
> > > > > > > proportion "X GB / Y GB avail" to calculate available space%. I
> > > > > > > plan
> > > > > > > to graph those values via zabbix and set up triggers for certain
> > > > > > > tresholds.
> > > > > > > May be somebody already has written shell parser for getting
> > > > > > > values
> > > > > > > from output of these commands?
> > > > > > > 
> > > > > > > Probably this ir wider question - what is the intended approach
> > > > > > > for
> > > > > > > ceph cluster monitoring? What do you guys use?
> > > > > > 
> > > > > > You might want to take a look at:
> > > > > > http://tracker.newdream.net/issues/685
> > > > > > 
> > > > > > In version 0.35 a json output was added. I've never tried it before,
> > > > > > but
> > > > > > you might want to look at that.
> > > > > 
> > > > > Currently, the only command that will output useful json for this
> > > > > kind of
> > > > > thing is 'ceph report'. I am finishing up on a patch to add json
> > > > > output
> > > > > capabilities to 'ceph health' and 'ceph status' though, but wasn't
> > > > > aiming
> > > > > at doing it with such level of detail -- basically, just output the
> > > > > same
> > > > > info as their plain counterparts, but using json instead.
> > > > 
> > > > I'm interested in this topic as well. What is also needed is a way to
> > > > query
> > > > the state of the individual daemons on each machine in the cluster.
> > > > 
> > > > Regards,
> > > >    Dennis
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
