From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Thu, 30 Jul 2015 14:26:15 -0400 (EDT)
Message-ID: <1563403567.1093721.1438280774967.JavaMail.zimbra@redhat.com>
References: <20150623093325.GH10754@orbis-terrarum.net> <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com> <robbat2-20150623T230410-006258787Z@orbis-terrarum.net> <854662566.18884035.1435100864177.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:49087 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbG3S0g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 14:26:36 -0400
In-Reply-To: <854662566.18884035.1435100864177.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>



----- Original Message -----
> From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> To: "Robin H. Johnson" <robbat2@gentoo.org>
> Cc: ceph-devel@vger.kernel.org, "Jonathan LaCour" <jonathan.lacour@dreamhost.com>
> Sent: Tuesday, June 23, 2015 4:07:44 PM
> Subject: Re: RGW S3 Website hosting, non-clean code for early review
> 
> 
> 
> ----- Original Message -----
> > From: "Robin H. Johnson" <robbat2@gentoo.org>
> > To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> > Cc: ceph-devel@vger.kernel.org, "Jonathan LaCour"
> > <jonathan.lacour@dreamhost.com>
> > Sent: Tuesday, June 23, 2015 4:04:49 PM
> > Subject: Re: RGW S3 Website hosting, non-clean code for early review
> > 
> > 
> > On Tue, Jun 23, 2015 at 04:30:19PM -0400, Yehuda Sadeh-Weinraub wrote:
> > > > Either I have to repeat a lot of code for it, which I'm not happy
> > > > about,
> > > > or I have to refactor RGWGetObj* to more safely made the second GET
> > > > request for the error object (and make sure range headers etc are NOT
> > > > used for the get of the error object). I'm leaning to the latter.
> > > Is generating a new req_state a possibility? E.g., you catch the error
> > > at the top level, and restart most of the request processing with a
> > > newly created req_state?
> > That was the path I was trying, but not completely succeeding.
> > I think need to step it back further and have a partially customized
> > copy of the RGWEnv from client_io->get_env(), so that I can build the
> > modified req_info for req_state.
> > 
> > It isn't a full new GET really, it's really just custom content for the
> > body as well as some headers (mostly Content-Length, Content-Type), but
> > ignore EPERM/EACCESS on trying to fetch that custom content, and if they
> > are detected, consider that a success but with different HTML content.
> > 
> > > Great! I'll wait for the cleaned up pull request.
> > Do you want pull requests per logical change of my proposed series
> > split, or rather just one pull request with the full series?
> > 
> 
> One pull request for the full series.
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi,

just following up on this one. I don't remember seeing a pull request. Has there been any progress?

Thanks,
Yehuda
