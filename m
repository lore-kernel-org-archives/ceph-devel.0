From: Smart Weblications GmbH <info@smart-weblications.de>
Subject: Re: rados mailbox? (was Re: Ceph for email storage)
Date: Tue, 10 Jul 2012 16:35:52 +0200
Message-ID: <4FFC3DC8.2090707@smart-weblications.de>
References: <4FF48B9C.3010803@webcenter.com.br> <Pine.LNX.4.64.1207041317110.6931@cobra.newdream.net> <4FFBC192.8060206@cybernetik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx03.smart-weblications.de ([188.65.144.38]:48312 "EHLO
	mx03.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751970Ab2GJOnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Jul 2012 10:43:09 -0400
In-Reply-To: <4FFBC192.8060206@cybernetik.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kristofer <kristofer@cybernetik.net>
Cc: Sage Weil <sage@inktank.com>, Mitsue Acosta Murakami <mitsue@webcenter.com.br>, ceph-devel@vger.kernel.org

Am 10.07.2012 07:45, schrieb Kristofer:
> Very short answer to this.
>=20
> It can work if you direct all email requests for a particular mailbox=
 to a
> single machine. You need to avoid locking between servers as much as =
possible.
>=20
> Messages will need to be indexed, period.  Or else your life will suc=
k.
>=20
> Dovecot has a nice writeup on this type of thing; not Ceph specific, =
but NFS
> related..it can be extrapolated to Ceph or any distributed storage:
> http://wiki.dovecot.org/NFS


>>
>>   - each mail message is a rados object, and immutable.
>>   - each mailbox is an index of messages, stored in a rados object.
>>     - the index consists of omap records, one for each message.
>>     - the key is some unique id
>>     - the value is a copy of (a useful subset of) the message header=
s
>>
>> This has a number of nice properties:
>>
>>   - you can efficiently list messages in the mailbox using the omap
>>     operations
>>   - you can (more) efficiently search messages (everything but the m=
essage
>>     body) based on the index contents (since it's all stored in one =
object)
>>   - you can efficiently grab recent messages with the omap ops (e.g.=
, list
>>     keys > last_seen_msgid)
>>   - moving messages between folders involves updating the indices on=
ly; the
>>     messages objects need not be copied/moved.
>>   - no metadata bottleneck: mailbox indices are distributed across t=
he
>>     entire cluster, just like the mail.
>>   - all the scaling benefits of rados for a growing mail system.
>>
>> I don't know enough about what exactly the mail storage backends nee=
d to
>> support to know what issues will come up.  Presumably there are seve=
ral.
>> E.g., if you delete a message, is the IMAP client expected to discov=
er
>> that efficiently?  And do the mail storage backends attempt to do it
>> efficiently?
>>
>> This also doesn't solve the problem of efficiently indexing/searchin=
g the
>> bodies of messages, although I suspect that indexing could be effici=
ently
>> implemented on top of this scheme.
>>
>> So, a non-trivial project, but probably one that can be prototyped w=
ithout
>> that much pain, and one that would perform and scale drastically bet=
ter
>> than existing solutions I'm aware of.
>>
>> I'm hoping there are some motivated hackers lurking who understand t=
he
>> pain that is maildir/mail infrastructure...
>>

Maybe another idea which could be done with few effort would be to most=
ly reuse
the code from dbmail and make a cephmail version out of it.


--=20

Mit freundlichen Gr=FC=DFen,


Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
