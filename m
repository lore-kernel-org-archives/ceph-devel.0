From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 12:14:01 +0300
Message-ID: <4BFB94D9.5080904@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFAD59E.2010706@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/24/2010 10:38 PM, Anthony Liguori wrote:
>
>> - Building a plugin API seems a bit simpler to me, although I'm to
>> sure if I'd get the
>>    idea correctly:
>>    The block layer has already some kind of api (.bdrv_file_open, 
>> .bdrv_read). We
>>    could simply compile the block-drivers as shared objects and 
>> create a method
>>    for loading the necessary modules at runtime.
>
> That approach would be a recipe for disaster.   We would have to 
> introduce a new, reduced functionality block API that was supported 
> for plugins.  Otherwise, the only way a plugin could keep up with our 
> API changes would be if it was in tree which defeats the purpose of 
> having plugins.

We could guarantee API/ABI stability in a stable branch but not across 
releases.

-- 
error compiling committee.c: too many arguments to function

