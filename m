From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Bucket name restrictions in RGW
Date: Fri, 12 Jun 2015 19:13:48 -0400 (EDT)
Message-ID: <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com> <557B2875.1090505@42on.com> <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:50466 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbbFLXNs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 19:13:48 -0400
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t5CNDmoK002628
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 19:13:48 -0400
In-Reply-To: <robbat2-20150612T220814-235406925Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Whatever we end up doing, we need to make it configurable, and also keep backward compatibility, so that buckets that were created prior to such a change will still remain accessible. Some setups would not need this limitation and will find it too restricting so I'm not sure that it's really that needed. In short, make it configurable.

Yehuda

----- Original Message -----
> From: "Robin H. Johnson" <robbat2@gentoo.org>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, June 12, 2015 3:50:48 PM
> Subject: Re: Bucket name restrictions in RGW
> 
> On Fri, Jun 12, 2015 at 08:44:05PM +0200,  Wido den Hollander wrote:
> > > In case we plan to support website hosting in future on RGW,
> Yes, I'm working on this presently. You can find the work in my fork on
> Github, and the scratchpad documentation here:
> https://github.com/robbat2/temp-ceph-rgw-static-website-wiki/wiki
> 
> > > need to make bucket names DNS compliant. Keeping that in mind, I am
> > > thinking about modifying the bucket name rules and applying more
> > > restrictions to make them more towards DNS compliant.
> > > 
> > > Please share your opinion about this.
> > I'm in favor. I would even like more strict bucket names, eg a setting
> > where you can force all names to lowercase or refuse names with
> > uppercase in it. This sometimes gives conflicts with DNS names when
> > using lower and uppercase mixed.
> Some of the below will be known to the existing posters on this thread,
> but as it's probably novel to some people on the list, I include it
> anyway. Feel free to jump to the 'Questions' section for the moment.
> 
> Background:
> -----------
> AmazonS3 bucket names were originally used in path style, as the first
> argument in the path. Ability to use them in as prefix in the hostname
> came later.
> 
> In the US-Standard region, you can still create such names even, you
> just can't use them with hostname-style access. In other regions, they
> are much stricter than the Ceph S3 code presently:
> http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html
> 
> Path-style access is still valid, and expected for some cases, esp when
> SSL is being used.
> 
> Details:
> --------
> The existing RGW code has 3 sets of validation:
> RGWHandler_ObjStore::validate_bucket_name
> - length 3..255
> 
> RGWHandler_ObjStore_SWIFT::validate_bucket_name
> - RGWHandler_ObjStore::validate_bucket_name AND
> - does not start with '.' AND
> - is valid UTF8 AND
> - does not contain any 0xFF bytes
> 
> RGWHandler_ObjStore_S3::validate_bucket_name(relaxed_names = true)
> - RGWHandler_ObjStore::validate_bucket_name AND
> - starts with [a-z0-9] AND
> - contains only [-._A-Za-z0-9] AND
> - is not an IPv4 address [2]
> 
> RGWHandler_ObjStore_S3::validate_bucket_name(relaxed_names = false)
> - RGWHandler_ObjStore::validate_bucket_name AND
> - starts with [0_-9A-Za-z0-9] AND
> - contains only [-._A-Za-z0-9] AND
> - is not an IPv4 address [2]
> 
> Right now, the AmazonS3 constraints, for new buckets [1] in regions
> other than US-Standard, or created via the management console are: (if
> they already exist, you can continue to use them)
> - length 3..63
> - one or more labels, separated with exactly one single period '.'
>   - each label must start and end with [a-z0-9]
>   - must contain only [-a-z0-9]
> - is not an IPv4 address [3]
> 
> Questions:
> ----------
> 
> Now that we've got both Ceph's current behavior and currently enforced
> S3 constraints documented, we have some questions to decide on.
> - Since we've allowed such flexibility in the past, how should we handle
>   access to existing non-complaint buckets in future? Right now
>   RGWHandler_ObjStore_S3 will reject ANY access to a non-compliant
>   bucket name, even if it was created before the restrictions were so
>   tight.
> - This also applies to creating buckets with 'rgw relaxed s3 bucket
>   names' enabled, then turning it off, and trying to access the bucket.
> - What happens if you create a bucket via Swift, compliant with Swift
>   constraints, and then try to access it via S3? What SHOULD happen?
>   I don't use swift at all, so I'm really unsure about this.
> 
> Footnotes:
> ----------
> 1. I include them because I've seen the older versions, and there
> doesn't seem to be way to easily see those again, archive.org doesn't
> have it.
> 2. looks_like_ip_address will actually reject anything that matches the
>    regex of /^([0-9]+\.){3}[0-9]+$/, so if each element is larger than
>    255, it will reject it as well.
> 3. They just say "Bucket names must not be formatted as an IP address
>    (e.g., 192.168.5.4)"; they don't clarify edge cases.
> 
> --
> Robin Hugh Johnson
> Gentoo Linux: Developer, Infrastructure Lead
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
