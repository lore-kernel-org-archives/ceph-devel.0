From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PGP signatures for RHEL hammer RPMs for ceph-deploy
Date: Tue, 5 Jan 2016 17:11:03 -0500
Message-ID: <CAC-Np1zJJ_vO7dW5nmotYWpuZstKNgT0LHWrM+VK_Jzj0tVaEA@mail.gmail.com>
References: <568BE1C8.7020308@umiacs.umd.edu>
	<CAC-Np1xN9j4w9mnj0L9e=je=j+LBjwbmG_Cr8b7iPvV5BeCCpg@mail.gmail.com>
	<CAC-Np1zzRABXKYYasWtMLtpOsEg6uVutbJart4Vajc+LOCoa+A@mail.gmail.com>
	<568C25D4.3020505@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <568C25D4.3020505-+0HnD9Kv66LFajBVf7NWsQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Derek Yarnell <derek-+0HnD9Kv66LFajBVf7NWsQ@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

It seems that the metadata didn't get updated.

I just tried out and got the right version with no issues. Hopefully
*this* time it works for you.

Sorry for all the troubles

On Tue, Jan 5, 2016 at 3:21 PM, Derek Yarnell <derek-+0HnD9Kv66LFajBVf7NWsQ@public.gmane.org> wrote:
> Hi Alfredo,
>
> I am still having a bit of trouble though with what looks like the
> 1.5.31 release.  With a `yum update ceph-deploy` I get the following
> even after a full `yum clean all`.
>
> http://ceph.com/rpm-hammer/el6/noarch/ceph-deploy-1.5.31-0.noarch.rpm:
> [Errno -1] Package does not match intended download. Suggestion: run yum
> --enablerepo=Ceph-noarch clean metadata
>
> Thanks,
> derek
>
> On 1/5/16 1:25 PM, Alfredo Deza wrote:
>> It looks like this was only for ceph-deploy in Hammer. I verified that
>> this wasn't the case in e.g. Infernalis
>>
>> I have ensured that the ceph-deploy packages in hammer are in fact
>> signed and coming from our builds.
>>
>> Thanks again for reporting this!
>>
>> On Tue, Jan 5, 2016 at 12:27 PM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> This is odd. We are signing all packages before publishing them on the
>>> repository. These ceph-deploy releases are following a new release
>>> process so I will
>>> have to investigate where is the disconnect.
>>>
>>> Thanks for letting us know.
>>>
>>> On Tue, Jan 5, 2016 at 10:31 AM, Derek Yarnell <derek-+0HnD9Kv66LFajBVf7NWsQ@public.gmane.org> wrote:
>>>> It looks like the ceph-deploy > 1.5.28 packages in the
>>>> http://download.ceph.com/rpm-hammer/el6 and
>>>> http://download.ceph.com/rpm-hammer/el7 repositories are not being PGP
>>>> signed.  What happened?  This is causing our yum updates to fail but may
>>>> be a sign of something much more nefarious?
>>>>
>>>> # rpm -qp --queryformat %{SIGPGP}
>>>> http://download.ceph.com/rpm-hammer/el6/noarch/ceph-deploy-1.5.28-0.noarch.rpm
>>>> 89021c040001020006050255fae0d5000a0910e84ac2c0460f3994203610009e284c0c6749f9d1ccd54aca8668e5f4148eb60f0ade762a5cb316926060d73a82490c41b8a5e9a5ebb8a7136a5ce294565cf8548dce160f7a577b623f12fb841b1656fba0b139404b4a074c076abf8c38f176bbecfc551567d22826d6c3ac2a67d8c8f4db67e3a2566272f492f3a1461b2c80bfc56f0c29e3a0c0e03fe50ee877d2d2b99963ea876914f5d85ae6fcf60c7c372040fcc82591552af21e152a37ab4103c3116ccd3a5f10992dc9ec483922212ef8ad8c37abbb6a751f6da2cc79567ed45e7bcb83d92aecc2a61d7584699183622714376bf3766e8781c7675834cce7d3e6c349bee6992872248fe7dd9f00248806e0c99f1a7010a8e77d13fefffeb142c1ee4ee8e55e53043fb89b7127a1c2282f4ab0fa3d19eccaa38194aa42310860bdd7746de8512b106d7923e9da9d1ad84b4ba1f8a3175b808d08f99ca5b737d4a7cba1f165b815187bec9ff1e0b5627e435ed869ae0bb16419e928e1a64413bb4dd62a6b1b049faa02eaa14
 bd6636b5f835bfef16acfd2daad82c1fed57a5e635971281367d2fe99c3b2b542490559d9b9b3f4295c86185aa3c4b4014da55c1b0ff68bc42c869729fee29472c413c911ea9bc5d58957bfb670ddc54d28fd8f30444969b790e53f9d34a1b
 2
>
>  df9b
>>>>
>>>>  e2afe9d26
>>>> d5be57b9fcd659c4880fad613ba5f175e4e3466dba4919a4656ffd228688a9c81d865e6df870ba33bbfc000
>>>>
>>>> # rpm -qp --queryformat %{SIGPGP}
>>>> http://download.ceph.com/rpm-hammer/el6/noarch/ceph-deploy-1.5.29-0.noarch.rpm
>>>> (none)
>>>>
>>>> # rpm -qp --queryformat %{SIGPGP}
>>>> http://download.ceph.com/rpm-hammer/el6/noarch/ceph-deploy-1.5.30-0.noarch.rpm
>>>> (none)
>>>>
>>>> # rpm -qp --queryformat %{SIGPGP}
>>>> http://download.ceph.com/rpm-hammer/el7/noarch/ceph-deploy-1.5.28-0.noarch.rpm
>>>> 89021c040001020006050255fadf42000a0910e84ac2c0460f39943b131000cb7f253c91019b2f5993fd232c4369003d521538aa19f996717d2eee780fe2d7ed4e969418ce92d6ad4be69b3c5421b80d2241a9d6e72e758ba86f0360e24aadd63d89165b47a566bcd8bed39d7b37e809d7afdf6b38e5e014f98caca6df7da6278822e2457c627cdba505febc23edb32447e11c2878e79bf5f5690def708ed7d79d261a839d5808b177cb3d6a8bc62317441f3e1b5cf986aeb5cde98fc986c42af2761418e7e83309df9b8703648a8e6eefe83f9d3cbcfe371bc336320657f86343ab25df8bd578203b6f312746ebbe0da195adeb1087487d12d530281b5328731c54240b0c5c01f1648c8802231876a33a0835a553e1b84e6d8a15acdd5db6b6bf9c6dee84b22ae0e70dc0cf2acdd5779e510a248844bba0af87ae8d5a874502ec0e48b235926222cf3386c44e30e3af14dea6134a5873784013297fa19a09f439bc8a2b73f563fc6e5cfa60767629a37f3cd24762f7b14e5f7ce08adeed82da3effc59298359a9f7f0efab0e4e
 808a33ceb07431530e0c279462da043bbece02d3fdf6a96e5a813eea0bf0f73e84b7fac6e28449e1bf15ddc2fa692f641ce8d4d9ed4261ba2824adee47dad90993ebc46d6ee083e92c8f76aaf8428e274e48cb1a91d0a2eb15e8779289b377
 1
>
>  ef71
>>>>
>>>>  1cd9cc7f2
>>>> 8f7a3cde708e4577b0aad546024ee98646f4f543ee1e33d8c96a93cff9b48deefa5b3996f659b16786ff016
>>>>
>>>> # rpm -qp --queryformat %{SIGPGP}
>>>> http://download.ceph.com/rpm-hammer/el7/noarch/ceph-deploy-1.5.29-0.noarch.rpm
>>>> (none)
>>>>
>>>> # rpm -qp --queryformat %{SIGPGP}
>>>> http://download.ceph.com/rpm-hammer/el7/noarch/ceph-deploy-1.5.30-0.noarch.rpm
>>>> (none)
>>>>
>>>> --
>>>> Derek T. Yarnell
>>>> University of Maryland
>>>> Institute for Advanced Computer Studies
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
> --
> Derek T. Yarnell
> University of Maryland
> Institute for Advanced Computer Studies
