From: Loic Dachary <loic@dachary.org>
Subject: Re: Virtualenv tests still nort running...
Date: Wed, 30 Mar 2016 12:10:04 +0200
Message-ID: <56FBA5FC.6040001@dachary.org>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
 <56FA9B5C.5060307@digiware.nl> <56FB9BA0.2060901@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43955 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcC3KKK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 06:10:10 -0400
In-Reply-To: <56FB9BA0.2060901@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Willem,

Would you mind proposing a pull request with that change ? It looks goo=
d to me.

Cheers

On 30/03/2016 11:25, Willem Jan Withagen wrote:
> On 29-3-2016 17:12, Willem Jan Withagen wrote:
>> On 29-3-2016 14:28, Loic Dachary wrote:
>>> Hi Willem,
>>>
>>> This has undergone various fixes all of them wrong in a context or
>>> another. The last of them is (hopefully ;-)
>>> https://github.com/ceph/ceph/pull/8320
>>
>> Hi Loic,
>>
>> I watched the discussion carefully, and was under the assemption tha=
t
>> everything was already merged. But I'll take your pull and see what =
happens.
>=20
> Hi Loic,
>=20
> I saw that #8320 was merged and rebased. So running/compiling to see
> what brings.
>=20
> There might be one change that you'd care to take along in this as we=
ll,
> which I have to keep my tests running ATM.
> Otherwise I'll just keep it in my patchset to the time to come.
>=20
> --WjW
>=20
> : ${CEPH_DETECT_INIT_VIRTUALENV:=3Dceph-detect-init-virtualenv}
>=20
> case `uname` in
>  FreeBSD)
>     echo FreeBSD init system has not been integrated.
>     exit 0
>     ;;
>  *)
>     # run from the ceph-detect-init directory or from its parent
>     test -d ceph-detect-init && cd ceph-detect-init
>     source ${CEPH_DETECT_INIT_VIRTUALENV}/bin/activate
>     tox > ${CEPH_DETECT_INIT_VIRTUALENV}/tox.out 2>&1
>     status=3D$?
>     grep -v InterpreterNotFound < ${CEPH_DETECT_INIT_VIRTUALENV}/tox.=
out
>     exit $status
>     ;;
> esac
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
