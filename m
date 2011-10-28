From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [RFC PATCH v3 1/4] secret: add Ceph secret type
Date: Fri, 28 Oct 2011 10:33:51 -0600
Message-ID: <4EAAD96F.6040500@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>	<539f3129dfd5d3f80a06837b63dfc5d355f1acc8.1319072460.git.josh.durgin@dreamhost.com> <20111027082845.GA20878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4690 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755484Ab1J1Qd6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Oct 2011 12:33:58 -0400
In-Reply-To: <20111027082845.GA20878@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/27/2011 02:28 AM, Daniel P. Berrange wrote:
> On Thu, Oct 20, 2011 at 11:01:24AM -0700, Josh Durgin wrote:
>> From: Sage Weil<sage@newdream.net>
>>
>> Add a new secret type to store a Ceph authentication key. The name
>> is simply an identifier for easy human reference.
>>
>> The xml looks like this:
>>
>> <secret ephemeral='no' private='no'>
>>    <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
>>    <usage type='ceph'>
>>      <name>mycluster_admin</name>
>>    </usage>
>> </secret>
>>
>> Signed-off-by: Sage Weil<sage@newdream.net>
>> Signed-off-by: Josh Durgin<josh.durgin@dreamhost.com>
>> ---
>>   docs/schemas/secret.rng      |   10 ++++++++++
>>   include/libvirt/libvirt.h.in |    3 +++
>>   src/conf/secret_conf.c       |   23 ++++++++++++++++++++++-
>>   src/conf/secret_conf.h       |    1 +
>>   src/secret/secret_driver.c   |    8 ++++++++
>>   5 files changed, 44 insertions(+), 1 deletions(-)
>
> ACK

I can't find the mail you are replying to, in order to apply it to the 
libvirt tree; was it accidentally sent off-list?  Can anyone point me to 
a git tree with this patch series ready to be merged, or else resend it?

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
