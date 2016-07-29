From: Loic Dachary <loic@dachary.org>
Subject: Re: Plugins unification
Date: Fri, 29 Jul 2016 15:42:27 +0200
Message-ID: <579B5D43.3000208@dachary.org>
References: <CAHMeWhGepAWaeec1wLQoRgV5yAtJ0Jg8FXu65sR43RREtbcqFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56393 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcG2Nmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 09:42:31 -0400
In-Reply-To: <CAHMeWhGepAWaeec1wLQoRgV5yAtJ0Jg8FXu65sR43RREtbcqFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Kupczyk <akupczyk@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Adam,

I believe https://github.com/ceph/ceph/pull/7661 is addressing part of =
your plan.

Cheers

On 29/07/2016 14:40, Adam Kupczyk wrote:
> Hi cephers,
>=20
> I plan to unify ceph plugins.
>=20
> Currently we have 2 plugin trees:
> 1) erasure-code/ErasureCodePluginRegistry
> type of plugin: class ErasureCodePlugin
> instances:      class ErasureCodePluginJerasure
>                 class ErasureCodePluginSelectJerasure
>                 class ErasureCodePluginLrc
>                 class ErasureCodePluginSelectShec
>                 class ErasureCodePluginShec
> 2) common/PluginRegistry
> type of plugin: class Plugin
> specialization: class CompressionPlugin
> instances:        class CompressionPluginSnappy
>                 class CompressionPluginZlib
> future:
> specialization: class CryptoPlugin
> instances:        class CryptoPluginISAL
>=20
> The plan:
> 1) Get rid of EraseCodePluginRegistry.
> 2) Make EraseCodePlugin a specialization of class Plugin.
> 3) PluginRegistry will use ceph configuration for places to search fo=
r plugins.
> 4) PluginRegistry.load(...) will no longer get directory to search.
> 5) PluginRegistry will only return std::shared_ptr<Plugin> references=
=2E
> 6) PluginRegistry.remove(...) will only delete internal std::shared_p=
tr<Plugin>.
>    Actual dlclose() will be delayed until all references are deleted.
> 7) static EraseCodePlugin::factory(...), the replacement of
> EraseCodePluginRegistry::factory(...)
>    will return std::dynamic_pointer_cast<EraseCodePlugin>(located_plu=
gin)
> 8) Extend class Plugin to force instances to provide "type" and "name=
".
>=20
>=20
> I would really enjoy comments if such unification is beneficial, and
> comments what should be done better.
>=20
> Best Regards,
> Adam Kupczyk
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
