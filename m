From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Wed, 26 May 2010 11:46:04 +0300
Message-ID: <4BFCDFCC.2050008@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>  <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>  <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>  <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>  <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>  <4BFA5D96.3030603@redhat.com>  <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>  <4BFA696D.2060606@redhat.com>  <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com> <4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com> <4BFBD833.1030503@redhat.com> <4BFBF906.7010809@redhat.com> <Pine.LNX.4.64.1005250939440.8523@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005250939440.8523@cobra.newdream.net>
Sender: kvm-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 08:12 PM, Sage Weil wrote:
> On Tue, 25 May 2010, Avi Kivity wrote:
>    
>>> What's the reason for not having these drivers upstream? Do we gain
>>> anything by hiding them from our users and requiring them to install the
>>> drivers separately from somewhere else?
>>>
>>>        
>> Six months.
>>      
> FWIW, we (Ceph) aren't complaining about the 6 month lag time (and I don't
> think the Sheepdog guys are either).
>
>    

In that case (and if there are no other potential users), then there's 
no need for a plugin API.

-- 
error compiling committee.c: too many arguments to function

