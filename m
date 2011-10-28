From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [RFC PATCH v3 1/4] secret: add Ceph secret type
Date: Fri, 28 Oct 2011 12:56:38 -0600
Message-ID: <4EAAFAE6.7070500@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>	<539f3129dfd5d3f80a06837b63dfc5d355f1acc8.1319072460.git.josh.durgin@dreamhost.com>	<20111027082845.GA20878@redhat.com> <4EAAE960.9010308@redhat.com> <4EAAF8AD.8040701@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab1J1S4p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Oct 2011 14:56:45 -0400
In-Reply-To: <4EAAF8AD.8040701@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/28/2011 12:47 PM, Josh Durgin wrote:
>
> Thanks, I'm not sure why the mail didn't go through to the libvirt list.
> It looks like there's a break missing in the pushed version though:
>
> diff --git a/src/conf/secret_conf.c b/src/conf/secret_conf.c
> index fa80888..a51fc69 100644
> --- a/src/conf/secret_conf.c
> +++ b/src/conf/secret_conf.c
> @@ -55,6 +55,7 @@ virSecretDefFree(virSecretDefPtr def)
>
> case VIR_SECRET_USAGE_TYPE_CEPH:
> VIR_FREE(def->usage.ceph);
> + break;

Apologies; that's what I get for manually applying your patch. :(

I've pushed a trivial fix for that...

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
