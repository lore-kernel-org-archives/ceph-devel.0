From: =?windows-1252?Q?Javier_Mu=F1oz?= <jmunhoz@igalia.com>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Wed, 02 Dec 2015 15:02:12 +0100
Message-ID: <565EF9E4.2020501@igalia.com>
References: <20150623093325.GH10754@orbis-terrarum.net> <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com> <robbat2-20150623T230410-006258787Z@orbis-terrarum.net> <854662566.18884035.1435100864177.JavaMail.zimbra@redhat.com> <1563403567.1093721.1438280774967.JavaMail.zimbra@redhat.com> <robbat2-20150731T080643-628065411Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp3.mundo-r.com ([212.51.32.191]:33234 "EHLO
	smtp4.mundo-r.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758371AbbLBOMq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Dec 2015 09:12:46 -0500
In-Reply-To: <robbat2-20150731T080643-628065411Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>

Hi,

I would appreciate to know the current status of the implementation if
possible. Any progress? Any 'deadline' to go upstream? :)

Thanks in advance!

Javier

On 07/31/2015 10:21 AM, Robin H. Johnson wrote:
> I'm busy travelling and wrapping other things up, but will resume major
> work on this in August, probably week 2/3, depending on other
> interrupts/priorities.
> 
> It's almost complete, the only missing features are:
> - error page fetcher gets confused on conditional requests (I think a
>   different approach is needed, esp re range & if-modified requests,
>   they still seem to leak into the custom req_info on the second request)
> - cascaded errors on conditional requests need more handling (eg
>   404 bounces to the error page that doesn't exist as well)
> Some further work that isn't blocking is also:
> - review handling of x-amz-website-redirect-location header when it
>   conflicts with RoutingRules
> - Check what input validations Amazon does, because already they don't
>   match the docs 
>   - eg docs say any http code for redirect, but it really only allows
> 	301-305, 307, 308
>   - Exact validation on the URI/paths is also not immediately clear, I
> 	had some unexpected results with URL-escaped inputs.
> - Review cases in which AMZ sets the errors in the header as well as the
>   page, didn't seem consistent, esp in the double-error cases.
> - more cleanup/refactor of test cases
> 

