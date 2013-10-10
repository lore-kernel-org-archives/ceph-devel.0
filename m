From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: OpenStack and ceph integration with puppet
Date: Thu, 10 Oct 2013 13:55:50 -0400
Message-ID: <CANtztVyp+4oARcWq0y04_mr24-cNnMJ2QuF65YD1hmSdxf5YwQ@mail.gmail.com>
References: <525413DE.9090405@dachary.org>
	<57ED724085B72141BB091CF1314E471F01769708@xmb-rcd-x15.cisco.com>
	<5255CEB2.8080809@dachary.org>
	<5256CB13.5020203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:52697 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab3JJRzv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Oct 2013 13:55:51 -0400
Received: by mail-qc0-f176.google.com with SMTP id t7so2064490qcv.7
        for <ceph-devel@vger.kernel.org>; Thu, 10 Oct 2013 10:55:50 -0700 (PDT)
In-Reply-To: <5256CB13.5020203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Don Talton (dotalton)" <dotalton@cisco.com>, Ceph Development <ceph-devel@vger.kernel.org>, Dan Bode <bodepd@gmail.com>

On Thu, Oct 10, 2013 at 11:43 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 09/10/2013 22:46, Loic Dachary wrote:
>>
>>
>> On 08/10/2013 16:20, Don Talton (dotalton) wrote:> Hi Loic,
>>>
>>
>>> We utilize stackforge's puppet modules to do our heavy lifting, inc=
luding p-openstack, p-cinder, p-glance. There are dependency chains so =
that services will be restarted after configuration changes are made. S=
ince many of our customers don't allow their baremetal  nodes Internet =
access, we've added the packages to our APT repo to avoid the version i=
ssues with using either stock or public packages.
>>>
>>> You can probably find some other useful code the https://github.com=
/CiscoSystems/ repo, including what is needed to cohabitate MON/OSD nod=
es with OpenStack service nodes (https://github.com/CiscoSystems/puppet=
-coe/tree/grizzly/manifests/ceph) and more. The primary orchestration i=
s in grizzly-manifests. You can see HOWTOs for different deployment sce=
narios here: http://docwiki.cisco.com/wiki/OpenStack:Ceph-COI-Installat=
ion.
>>>
>>> Hope this helps some!
>>
>> It does and it's great that all this is documented :-) Although ther=
e are a few modules around, re-using ceph-deploy seems to be the prefer=
red method. I wonder what Alfredo would suggest. From a previous discus=
sion we had I think he will suggest to use ceph-disk directly + cli / r=
est call instead. Looking at
>>
>> https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/new.py
>> https://github.com/ceph/ceph-deploy/blob/master/ceph_deploy/mon.py
>> etc.
>>
>> the layer provided by ceph-deploy is indeed thin. But is it somethin=
g that needs to be duplicated in a puppet module ?
>>
>
> I took a look at ceph-deploy and it won't rely on sudo if run from ro=
ot
>
> ceph_deploy/sudo_pushy.py
> def needs_sudo():
>     if getpass.getuser() =3D=3D 'root':
>         return False
>     return True
>
> and that it won't rely on ssh if the target host is localhost:
>
> ceph_deploy/lib/remoto/connection.py
> def needs_ssh(hostname, _socket=3DNone):
>     """
>     Obtains remote hostname of the socket and cuts off the domain par=
t
>     of its FQDN.
>     """
>     _socket =3D _socket or socket
>     local_hostname =3D _socket.gethostname()
>     local_short_hostname =3D local_hostname.split('.')[0]
>     if local_hostname =3D=3D hostname or local_short_hostname =3D=3D =
hostname:
>         return False
>     return True
>
> Since puppet-cephdeploy runs on the target host as root, it means tha=
t
>
> puppet-cephdeploy/manifests/init.pp
>   file {"/home/$user/.ssh/authorized_keys":
> ...
> etc.
>
> could probably be avoided since puppet-cephdeploy/manifests/mon.pp ru=
ns
>
> command =3D> "/usr/local/bin/ceph-deploy mon create $::hostname",
>
> runs as root, on the target host.

Loic is spot on here. Yes, ceph-deploy will avoid all of those things
described if they are not necessary. The one possible caveat is when
there is
an ~/.ssh/config that changes the login of a remote user to something
else which ceph-deploy would not be able to tell.

So say you have a `node1` defined in the ssh config with user `foo`
but you are executing ceph-deploy as `root`, then that would mean
that ceph-deploy would not run `sudo` commands in the remote host
because it assumes the ssh is happening with root.

If the manifest is doing all of this work locally, then this is not a
problem, but something to be aware of.
>
> I'm not sure if the distribution of the keys would work though as it =
relies on files collected by "gatherkeys" which is still a little myste=
rious for me :-)

gatherkeys will just go to standard locations and look for the
generated keys and copy them back to where ceph-deploy is executing
from. Really nothing
complex is  happening there.


>
> Cheers
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
