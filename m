From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Has rgw recently switched to deque usuage??
Date: Sun, 21 Feb 2016 06:00:41 -0500 (EST)
Message-ID: <1358966418.44210231.1456052441419.JavaMail.zimbra@redhat.com>
References: <56C87B29.5040005@digiware.nl> <1565267399.44124691.1456003985235.JavaMail.zimbra@redhat.com> <56C8E590.7090609@digiware.nl> <1135436239.44164632.1456013615024.JavaMail.zimbra@redhat.com> <56C9958E.5020008@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:38094 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbcBURfZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Feb 2016 12:35:25 -0500
In-Reply-To: <56C9958E.5020008@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

sure, send github pull request tagged "rgw" when ready

Matt

----- Original Message -----
> From: "Willem Jan Withagen" <wjw@digiware.nl>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, February 21, 2016 5:46:38 AM
> Subject: Re: Has rgw recently switched to deque usuage??
> 
> On 21-2-2016 01:13, Matt Benjamin wrote:
> > Hi Willem,
> > 
> > That's good news, but massive header re-ordering sounds suspicious.
> > Likely, there are just missing unix headers.
> 
> Overnight the build completed.
> Now running gmake check.
> If that gets to my normal level of PASSED of around 110 of 133 than I
> commit the rgw changes and you can find that in my pull to comment about
> and we take it from there.
> 
> --WjW
> 
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
