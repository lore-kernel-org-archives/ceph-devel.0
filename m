From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 08:54:27 -0500
Message-ID: <4BFBD693.2030108@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com> <4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com> <4BFBD0C6.9000105@codemonkey.ws> <4BFBD261.9040908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBD261.9040908@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 08:36 AM, Avi Kivity wrote:
>
> We'd need a kernel-level generic snapshot API for this eventually.
>
>> or (2) implement BUSE to complement FUSE and CUSE to enable proper 
>> userspace block devices.
>
> Likely slow due do lots of copying.  Also needs a snapshot API.

The kernel could use splice.

> (ABUSE was proposed a while ago by Zach).
>
>> If you want to use a block device within qemu, you almost certainly 
>> want to be able to manipulate it on the host using standard tools 
>> (like mount and parted) so it stands to reason that addressing this 
>> in the kernel makes more sense.
>
> qemu-nbd also allows this.
>
> This reasoning also applies to qcow2, btw.

I know.

Regards,

Anthony Liguori


