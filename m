From: Wido den Hollander <wido@42on.com>
Subject: Re: Bucket name restrictions in RGW
Date: Sat, 13 Jun 2015 22:24:37 +0200
Message-ID: <557C9185.1050305@42on.com>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com> <557B2875.1090505@42on.com> <robbat2-20150612T220814-235406925Z@orbis-terrarum.net> <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com> <robbat2-20150612T232131-467242919Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47974 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbbFMUYl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 13 Jun 2015 16:24:41 -0400
Received: from [IPv6:2a02:f6e:8007:0:2959:506:f3ac:544b] (unknown [IPv6:2a02:f6e:8007:0:2959:506:f3ac:544b])
	by websrv.42on.com (Postfix) with ESMTPSA id F1029C4B60
	for <ceph-devel@vger.kernel.org>; Sat, 13 Jun 2015 22:24:37 +0200 (CEST)
In-Reply-To: <robbat2-20150612T232131-467242919Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 06/13/2015 01:29 AM, Robin H. Johnson wrote:
> On Fri, Jun 12, 2015 at 07:13:48PM -0400,  Yehuda Sadeh-Weinraub wrote:
>> Whatever we end up doing, we need to make it configurable, and also
>> keep backward compatibility, so that buckets that were created prior
>> to such a change will still remain accessible. Some setups would not
>> need this limitation and will find it too restricting so I'm not sure
>> that it's really that needed. In short, make it configurable.
> Configurable:
> - Can we obsolete 'rgw relaxed s3 bucket names', and convert it to a new
>   option: 'rgw s3 bucket name create strictness'
>   Value '0' => existing 'rgw relaxed s3 bucket names = true' logic
>   Value '1' => existing 'rgw relaxed s3 bucket names = false' logic
>   Value '2' => compliance with AmazonS3 DNS rules
> 
> Backwards-Compatibility:
> - Make a new option 'rgw s3 bucket name access strictness'
>   Same values as above, but used to access buckets, not create new ones.
> - Proposed default values:
>   rgw s3 bucket name create strictness = 2
>   rgw s3 bucket name access strictness = 1
> 
> So you can only create DNS-compliant buckets, but still access your
> existing non-compliant buckets. Maybe also have keywords of major
> releases and 'relaxed' supported in addition to the integer values.
> 
> I don't like the names of the config keys, but I'm coming up blank on
> something that is shorter while still being immediately clear.
> 

Seems like a good plan to me. I would like to restrict them as much as
possible, but we shouldn't break anything which is online now.

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
