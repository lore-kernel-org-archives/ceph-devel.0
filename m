From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Ceph Auth
Date: Thu, 19 Nov 2009 15:12:09 -0800
Message-ID: <a37615150911191512s151a452cib2b6b3df03ae728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5775305709807719943=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--===============5775305709807719943==
Content-Type: multipart/alternative; boundary=0016369f9cea14a5a00478c17d95

--0016369f9cea14a5a00478c17d95
Content-Type: text/plain; charset=ISO-8859-1

We've been working in the past few months on implementing and polishing the
ceph authorization and trust mechanism. We had introduced the main idea
previously, but I think that now when most things are in place, we should
describe what we actually implemented, even though it is not very far from
what we originally conceived. At the moment the new auth system is merged
into the unstable branch and is fully active on the userspace side. There is
some more work to be done before it can be fully utilized on the kernel
client side.

In short, the ceph auth system allows each entity that participates in the
ceph cluster (services and clients) to have a unique id. A session is being
created when an entity needs to communicate with another one, and upon its
establishment the receiving side can be sure that the client (in this
client-server connection, though it can be any entity, not necessarily a
client) is who it says he is.

1. Secrets Repository

Each entity has a type (mon, osd, mds, client) and a name. Each entity needs
to have a record in the monitors auth state machine. This record is the
security record for this entity and it holds this specific entity's secret
and the different caps for different services. Each service has its own set
of caps and they basically set the things this entity can do. Most
in-cluster operations are filtered based on the entity-type, so that certain
operation can only be done by the cluster members (e.g., operation that can
only be done by mon, osd, mds). The clients operations are filtered based on
the caps that the clients have for the specific service type. For example, a
client can have a read-only permission to access one pool on the osd, while
it has a read/write access to another.

2. Initial Contact

When an entity connects to another entity, it needs to specify which
authentication protocol it is going to use for that connection. At the
moment there could be 3 options: unknown, none, cephx. The first contact for
each entity would be with the monitor which also has the role of the
authentication server. For this connection, all the entities will use the
'unknown' protocol as one has not been chosen yet. After successfully
connecting to the monitor, the entity sends a list of supported
authentication protocols from which the monitor will choose the one that
will be used. At the moment there are 2 options auth-none, which is
basically a do-nothing authentication, and auth-cephx, which is our
Kerberos-like implementation.

3. Cephx

a. Getting the Auth-Ticket

With the monitor's response that acknowledges the use of the cephx protocol
for the rest of this entity's life, it also submits a challenge. The entity
needs to respond this challenge with a challenge of its own and a response
that hashes those two challenges, using the entity's secret as the key. Upon
receiving this, the monitor (authenticator) knows that the entity is really
who it claims to be. The first response, is thus the 'auth' ticket, which
allows the entity to request tickets for connecting to other entities, and a
session key that will be used in conjunction with this ticket, and also
encoded inside this ticket.

b. Getting the Services Ticket

Now, that the entity (e.g., client, osd, mds) has the auth ticket, it can
send it with a list of requested services it wants to connect to. Note that
the authorizer is not obliged to accept all the requests, and it really
depends on the permissions that this entity has. Each service ticket will
hold the caps this entity has for this service. The service ticket is
encrypted, using a secret that the service knows (more about it later). Each
ticket has a corresponding session key as with the auth ticket.

c. Authorizing

Now, after the entity acquired the requested tickets to access the different
services it can actually connect to them. After connecting, it will use
'auth-cephx' as the selected auth protocol, and will supply an
'authorize-me' message that will consist of the ticket and some data (e.g.,
timestamp) encoded using the session key. The service will need be able to
decode the ticket using one of its internal keys, and decode the supplied
data using the session key embedded in the ticket. The response would
consist of the data altered (e.g., timestamp + 1) encoded using the session
key. After the entity successfully decodes this response, it is acknowledged
that this connection has been authenticated.

d. Rotating Secrets

One of the issues that we discusses was that we didn't want to require the
entire cluster of the different services hold the same secret, which could
be highly insecure. This led to a problem -- how do we send the client a
single ticket for the osds (or for all the mds) so that each of them will be
able to decrypt. The solution we came up was that each of the osds will have
a different 'master' key, but all of them will share secrets that will
change after a while. The same goes for the mds's. So when the mon creates a
ticket for the osds, it uses this 'rotating' secret so that all of the osds
will be able to decrypt it. Note that the services always keep 3 different
rotating secrets -- the previous one, the current and the next one, so that
there's no need to synchronize the entire cluster whenever one times out.
We don't use the rotating secrets for the monitors, and all the monitors are
sharing the same master key.

As always, any questions and remarks are welcome.

Yehuda

--0016369f9cea14a5a00478c17d95
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>We&#39;ve been working in the past few months on implementing and poli=
shing the ceph authorization and trust mechanism. We had introduced the mai=
n idea previously, but I think that now when most things are in place, we s=
hould describe what we actually implemented, even though it is not very far=
 from what we originally conceived. At the moment the new auth system is me=
rged into the unstable branch and is fully active on the userspace side. Th=
ere is some more work to be done before it can be fully utilized on the ker=
nel client side.</div>

<div><br></div><div>In short, the ceph auth system allows each entity that =
participates in the ceph cluster (services and clients) to have a unique id=
. A session is being created when an entity needs to communicate with anoth=
er one, and upon its establishment the receiving side can be sure that the =
client (in this client-server connection, though it can be any entity, not =
necessarily a client) is who it says he is.</div>

<div><br></div><div>1. Secrets Repository</div><div><br></div><div>Each ent=
ity has a type (mon, osd, mds, client) and a name. Each entity needs to hav=
e a record in the monitors auth state machine. This record is the security =
record for this entity and it holds this specific entity&#39;s secret and t=
he different caps for different services. Each service has its own set of c=
aps and they basically set the things this entity can do. Most in-cluster o=
perations are filtered based on the entity-type, so that certain operation =
can only be done by the cluster members (e.g., operation that can only be d=
one by mon, osd, mds). The clients operations are filtered based on the cap=
s that the clients have for the specific service type. For example, a clien=
t can have a read-only permission to access one pool on the osd, while it h=
as a read/write access to another.</div>

<div><br></div><div>2. Initial Contact</div><div><br></div><div>When an ent=
ity connects to another entity, it needs to specify which authentication pr=
otocol it is going to use for that connection. At the moment there could be=
 3 options: unknown, none, cephx. The first contact for each entity would b=
e with the monitor which also has the role of the authentication server. Fo=
r this connection, all the entities will use the &#39;unknown&#39; protocol=
 as one has not been chosen yet. After successfully connecting to the monit=
or, the entity sends a list of supported authentication protocols from whic=
h the monitor will choose the one that will be used. At the moment there ar=
e 2 options auth-none, which is basically a do-nothing authentication, and =
auth-cephx, which is our Kerberos-like implementation.</div>

<div><br></div><div>3. Cephx</div><div><br></div><div>a. Getting the Auth-T=
icket</div><div><br></div><div>With the monitor&#39;s response that acknowl=
edges the use of the cephx protocol for the rest of this entity&#39;s life,=
 it also submits a challenge. The entity needs to respond this challenge wi=
th a challenge of its own and a response that hashes those two challenges, =
using the entity&#39;s secret as the key. Upon receiving this, the monitor =
(authenticator) knows that the entity is really who it claims to be. The fi=
rst response, is thus the &#39;auth&#39; ticket, which allows the entity to=
 request tickets for connecting to other entities, and a session key that w=
ill be used in conjunction with this ticket, and also encoded inside this t=
icket.</div>

<div><br></div><div>b. Getting the Services Ticket</div><div><br></div><div=
>Now, that the entity (e.g., client, osd, mds) has the auth ticket, it can =
send it with a list of requested services it wants to connect to. Note that=
 the authorizer is not obliged to accept all the requests, and it really de=
pends on the permissions that this entity has. Each service ticket will hol=
d the caps this entity has for this service. The service ticket is encrypte=
d, using a secret that the service knows (more about it later). Each ticket=
 has a corresponding session key as with the auth ticket.</div>

<div><br></div><div>c. Authorizing</div><div><br></div><div>Now, after the =
entity acquired the requested tickets to access the different services it c=
an actually connect to them. After connecting, it will use &#39;auth-cephx&=
#39; as the selected auth protocol, and will supply an &#39;authorize-me&#3=
9; message that will consist of the ticket and some data (e.g., timestamp) =
encoded using the session key. The service will need be able to decode the =
ticket using one of its internal keys, and decode the supplied data using t=
he session key embedded in the ticket. The response would consist of the da=
ta altered (e.g., timestamp + 1) encoded using the session key.=A0After the=
 entity successfully decodes this response, it is acknowledged that this co=
nnection has been authenticated.</div>
<div><div><br></div><div>d. Rotating Secrets</div><div><br></div><div>One o=
f the issues that we discusses was that we didn&#39;t want to require the e=
ntire cluster of the different services hold the same secret, which could b=
e highly insecure. This led to a problem -- how do we send the client a sin=
gle ticket for the osds (or for all the mds) so that each of them will be a=
ble to decrypt. The solution we came up was that each of the osds will have=
 a different &#39;master&#39; key, but all of them will share secrets that =
will change after a while. The same goes for the mds&#39;s. So when the mon=
 creates a ticket for the osds, it uses this &#39;rotating&#39; secret so t=
hat all of the osds will be able to decrypt it. Note that the services alwa=
ys keep 3 different rotating secrets -- the previous one, the current and t=
he next one, so that there&#39;s no need to synchronize the entire cluster =
whenever one times out.</div>
<div>We don&#39;t use the rotating secrets for the monitors, and all the mo=
nitors are sharing the same master key.</div></div><div><br></div><div>As a=
lways, any questions and remarks are welcome.=A0</div><div><br></div><div>
Yehuda</div><div><br></div>

--0016369f9cea14a5a00478c17d95--


--===============5775305709807719943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5775305709807719943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============5775305709807719943==--
