From: Alfredo Deza <adeza@redhat.com>
Subject: Re: radosgw-agent failed to parse
Date: Tue, 3 Feb 2015 08:29:43 -0500
Message-ID: <CANtztVwMTVPrcM_c3dW+CUQ8456fuert5E9x5n+Nz5TCnNZ9hA@mail.gmail.com>
References: <31740_1422885416_54CF8227_31740_2351_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F804F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CANtztVx9RZs1h-vqLUNMWhq+PrWcAigzh7qb0dpzUeFXf6+Fgw@mail.gmail.com>
	<3704_1422888787_54CF8F53_3704_2219_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F80ED@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CANtztVyC40R1-os=cuqOnk+L7RdyxwQrPcTLHRXMftakxGyX-A@mail.gmail.com>
	<27334_1422897147_54CFAFFB_27334_10829_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F830B@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CANtztVw_eiHicsdF=_ed=BH3Gnnvy+m2zGG5YeBheiq5Ln4Zgw@mail.gmail.com>
	<21220_1422958354_54D09F12_21220_2924_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F88FE@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:59348 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965661AbbBCN3o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 08:29:44 -0500
Received: by mail-yh0-f53.google.com with SMTP id v1so18469836yhn.12
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 05:29:43 -0800 (PST)
In-Reply-To: <21220_1422958354_54D09F12_21220_2924_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F88FE@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This tells me that you are not using the latest released version of
the agent because we dropped the requirement for the `requests`
library
that is showing up in your tracebacks.

You will need to make sure that the agent is completely removed,
including the `requests` library and then install the latest agent
available
from the Python package Index (PyPI) with a Python installer (e.g.
`pip install radosgw-agent`) or if you feel comfortable use the latest
tip
from the master branch (I advice to use the former).


On Tue, Feb 3, 2015 at 5:12 AM,  <ghislain.chevalier@orange.com> wrote:
> Hi Alfredo,
>
> Here are the logs you requested using the original client.py python s=
cript.
>
> ---------------------------------------------------------------------=
-
> DIRECT LAUNCH USING CLI:KO
> radosgw-agent -v -c /etc/ceph/radosgw-agent/fr-rennes-radosgw1-sync.c=
onf_direct
> the standard output is also written in the log file configured in the=
 synchro file
>
> DEBUG:boto:Using access key provided by client.
> DEBUG:boto:Using secret key provided by client.
> DEBUG:boto:StringToSign:
> GET
>
>
> Tue, 03 Feb 2015 09:37:54 GMT
> /admin/config
> DEBUG:boto:Signature:
> AWS SBF7DQZ1ESR6Y34225H8:9i6/4do7tDpViolN1XdxgefMs3U=3D
> DEBUG:boto:url =3D 'http://openstorage.ushttp://openstorage.us/admin/=
config'
> params=3D{}
> headers=3D{'Date': 'Tue, 03 Feb 2015 09:37:54 GMT', 'Content-Length':=
 '0', 'Authorization': 'AWS SBF7DQZ1ESR6Y34225H8:9i6/4do7tDpViolN1Xdxge=
fMs3U=3D', 'User-Agent': 'Boto/2.20.1 Python/2.7.6 Linux/3.11.0-26-gene=
ric'}
> data=3DNone
> ERROR:root:Could not retrieve region map from destination
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/cli.py", line =
269, in main
>     region_map =3D client.get_region_map(dest_conn)
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 391, in get_region_map
>     region_map =3D request(connection, 'get', 'admin/config')
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 153, in request
>     result =3D handler(url, params=3Dparams, headers=3Drequest.header=
s, data=3Ddata)
>   File "/usr/lib/python2.7/dist-packages/requests/api.py", line 55, i=
n get
>     return request('get', url, **kwargs)
>   File "/usr/lib/python2.7/dist-packages/requests/api.py", line 44, i=
n request
>     return session.request(method=3Dmethod, url=3Durl, **kwargs)
>   File "/usr/lib/python2.7/dist-packages/requests/sessions.py", line =
421, in request
>     prep =3D self.prepare_request(req)
>   File "/usr/lib/python2.7/dist-packages/requests/sessions.py", line =
359, in prepare_request
>     hooks=3Dmerge_hooks(request.hooks, self.hooks),
>   File "/usr/lib/python2.7/dist-packages/requests/models.py", line 28=
7, in prepare
>     self.prepare_url(url, params)
>   File "/usr/lib/python2.7/dist-packages/requests/models.py", line 33=
4, in prepare_url
>     scheme, auth, host, port, path, query, fragment =3D parse_url(url=
)
>   File "/usr/lib/python2.7/dist-packages/urllib3/util.py", line 390, =
in parse_url
>     raise LocationParseError("Failed to parse: %s" % url)
> LocationParseError: Failed to parse: Failed to parse: openstorage.ush=
ttp:
>
> ---------------------------------------------------------------------=
-----------
> LAUNCH USING /etc/init.d/radosgw-agent shell script:KO
> /etc/init.d/radosgw-agent start /etc/ceph/radosgw-agent/fr-rennes-rad=
osgw1-sync.conf_direct
> Standard output:
> Starting radosgw-agent fr-rennes-radosgw1-sync.conf_direct
>
> Log File :
> 2015-02-03T10:51:00.794 4735:ERROR:root:Could not retrieve region map=
 from destination
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/cli.py", line =
269, in main
>     region_map =3D client.get_region_map(dest_conn)
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 391, in get_region_map
>     region_map =3D request(connection, 'get', 'admin/config')
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 153, in request
>     result =3D handler(url, params=3Dparams, headers=3Drequest.header=
s, data=3Ddata)
>   File "/usr/lib/python2.7/dist-packages/requests/api.py", line 55, i=
n get
>     return request('get', url, **kwargs)
>   File "/usr/lib/python2.7/dist-packages/requests/api.py", line 44, i=
n request
>     return session.request(method=3Dmethod, url=3Durl, **kwargs)
>   File "/usr/lib/python2.7/dist-packages/requests/sessions.py", line =
421, in request
>     prep =3D self.prepare_request(req)
>   File "/usr/lib/python2.7/dist-packages/requests/sessions.py", line =
359, in prepare_request
>     hooks=3Dmerge_hooks(request.hooks, self.hooks),
>   File "/usr/lib/python2.7/dist-packages/requests/models.py", line 28=
7, in prepare
>     self.prepare_url(url, params)
>   File "/usr/lib/python2.7/dist-packages/requests/models.py", line 33=
4, in prepare_url
>     scheme, auth, host, port, path, query, fragment =3D parse_url(url=
)
>   File "/usr/lib/python2.7/dist-packages/urllib3/util.py", line 390, =
in parse_url
>     raise LocationParseError("Failed to parse: %s" % url)
> LocationParseError: Failed to parse: Failed to parse: openstorage.ush=
ttp:
>
> ---------------------------------------------------------------------=
----------------------
> LAUNCH AS A SERVICE: OK
> service radosgw-agent start /etc/ceph/radosgw-agent/fr-rennes-radosgw=
1-sync.conf_direct
> standard output:
> Starting radosgw-agent fr-rennes-radosgw1-sync.conf_direct
>
> Log file:
> 2015-02-03T10:42:02.878 3162:INFO:urllib3.connectionpool:Starting new=
 HTTP connection (1): openstorage.us
>
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
--------
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
--------
> Here are the logs you requested using the altered client.py python sc=
ript.
>
> DIRECT LAUNCH USING CLI:OK
> radosgw-agent -v -c /etc/ceph/radosgw-agent/fr-rennes-radosgw1-sync.c=
onf_direct
> the standard output is also witten in the log file configured in the =
synchro file
>
> 2015-02-03T11:00:40.447 6158:DEBUG:boto:Using access key provided by =
client.
> 2015-02-03T11:00:40.447 6158:DEBUG:boto:Using secret key provided by =
client.
> 2015-02-03T11:00:40.448 6158:DEBUG:boto:StringToSign:
> GET
>
>
> Tue, 03 Feb 2015 10:00:40 GMT
> /admin/config
> 2015-02-03T11:00:40.448 6158:DEBUG:boto:Signature:
> AWS SBF7DQZ1ESR6Y34225H8:LUEBUrR9z1Bgbrj6F/XGrGF+8BM=3D
> 2015-02-03T11:00:40.448 6158:DEBUG:boto:url =3D 'http://openstorage.u=
s/admin/config'
> params=3D{}
> headers=3D{'Date': 'Tue, 03 Feb 2015 10:00:40 GMT', 'Content-Length':=
 '0', 'Authorization': 'AWS SBF7DQZ1ESR6Y34225H8:LUEBUrR9z1Bgbrj6F/XGrG=
=46+8BM=3D', 'User-Agent': 'Boto/2.20.1 Python/2.7.6 Linux/3.11.0-26-ge=
neric'}
> data=3DNone
> 2015-02-03T11:00:40.457 6158:INFO:urllib3.connectionpool:Starting new=
 HTTP connection (1): proxy
> 2015-02-03T11:00:40.467 6158:DEBUG:urllib3.connectionpool:Setting rea=
d timeout to None
> 2015-02-03T11:00:40.848 6158:DEBUG:urllib3.connectionpool:"GET http:/=
/openstorage.us/admin/config HTTP/1.1" 200 None
>
> ---------------------------------------------------------------------=
-----------
> LAUNCH USING /etc/init.d/radosgw-agent shell script:KO
> /etc/init.d/radosgw-agent start /etc/ceph/radosgw-agent/fr-rennes-rad=
osgw1-sync.conf_direct
> Standard output:
> Starting radosgw-agent fr-rennes-radosgw1-sync.conf_direct
>
> Log File :
> 2015-02-03T11:07:49.271 7513:INFO:urllib3.connectionpool:Starting new=
 HTTP connection (1): proxy
> 2015-02-03T11:07:49.654 7513:INFO:urllib3.connectionpool:Starting new=
 HTTP connection (1): proxy
> 2015-02-03T11:07:50.469 7513:ERROR:radosgw_agent.sync:finding number =
of shards failed
> 2015-02-03T11:07:50.470 7513:WARNING:radosgw_agent.sync:error prepari=
ng for sync, will retry. Traceback:
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/sync.py", line=
 26, in prepare_sync
>     syncer.prepare()
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/sync.py", line=
 202, in prepare
>     self.init_num_shards()
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/sync.py", line=
 73, in init_num_shards
>     self.num_shards =3D client.num_log_shards(self.src_conn, self.typ=
e)
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 285, in num_log_shards
>     out =3D request(connection, 'get', 'admin/log', dict(type=3Dshard=
_type))
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 160, in request
>     check_result_status(result)
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 116, in check_result_status
>     HttpError)(result.status_code, result.content)
> NotFound: Http error code 404 content <HTML><HEAD>
>
>
> ---------------------------------------------------------------------=
----------------------
> LAUNCH AS A SERVICE:KO
> service radosgw-agent start /etc/ceph/radosgw-agent/fr-rennes-radosgw=
1-sync.conf_direct
> standard output:
> Starting radosgw-agent fr-rennes-radosgw1-sync.conf_direct
>
> Log file:
> 2015-02-03T11:04:25.435 6872:ERROR:root:Could not retrieve region map=
 from destination
> Traceback (most recent call last):
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/cli.py", line =
269, in main
>     region_map =3D client.get_region_map(dest_conn)
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 396, in get_region_map
>     region_map =3D request(connection, 'get', 'admin/config')
>   File "/usr/lib/python2.7/dist-packages/radosgw_agent/client.py", li=
ne 158, in request
>     result =3D handler(url, params=3Dparams, headers=3Drequest.header=
s, data=3Ddata)
>   File "/usr/lib/python2.7/dist-packages/requests/api.py", line 55, i=
n get
>     return request('get', url, **kwargs)
>   File "/usr/lib/python2.7/dist-packages/requests/api.py", line 44, i=
n request
>     return session.request(method=3Dmethod, url=3Durl, **kwargs)
>   File "/usr/lib/python2.7/dist-packages/requests/sessions.py", line =
421, in request
>     prep =3D self.prepare_request(req)
>   File "/usr/lib/python2.7/dist-packages/requests/sessions.py", line =
359, in prepare_request
>     hooks=3Dmerge_hooks(request.hooks, self.hooks),
>   File "/usr/lib/python2.7/dist-packages/requests/models.py", line 28=
7, in prepare
>     self.prepare_url(url, params)
>   File "/usr/lib/python2.7/dist-packages/requests/models.py", line 33=
8, in prepare_url
>     "Perhaps you meant http://{0}?".format(url))
> MissingSchema: Invalid URL u'/admin/config': No schema supplied. Perh=
aps you meant http:///admin/config?
>
>
>
> Best regards
>
> -----Message d'origine-----
> De : alfredo.deza@inktank.com [mailto:alfredo.deza@inktank.com] De la=
 part de Alfredo Deza
> Envoy=C3=A9 : lundi 2 f=C3=A9vrier 2015 19:42
> =C3=80 : CHEVALIER Ghislain IMT/OLPS
> Cc : ceph-devel@vger.kernel.org
> Objet : Re: [Ceph-devel] radosgw-agent failed to parse
>
> If you use the `-v` flag you will get very verbose output.
>
> On Mon, Feb 2, 2015 at 12:12 PM,  <ghislain.chevalier@orange.com> wro=
te:
>> OK I will send them asap
>>
>> Logs are not very verbose.. Can I set a debug mode?
>>
>> -----Message d'origine-----
>> De : alfredo.deza@inktank.com [mailto:alfredo.deza@inktank.com] De l=
a
>> part de Alfredo Deza Envoy=C3=A9 : lundi 2 f=C3=A9vrier 2015 16:59 =C3=
=80 : CHEVALIER
>> Ghislain IMT/OLPS Cc :
>> Objet : Re: [Ceph-devel] radosgw-agent failed to parse
>>
>> That sounds suspicious because we haven't packaged a 1.2.1 release.
>>
>> The latest on PyPI is 1.2, which is the same in the master branch.
>>
>> Would you mind sending logs that show *how* the url is malformed (bo=
th when it is OK and when it is not) ?
>>
>> On Mon, Feb 2, 2015 at 9:53 AM,  <ghislain.chevalier@orange.com> wro=
te:
>>> HI,
>>>
>>> Thx for replying
>>>
>>> According to dpkg -l, it's 1.2.1.
>>>
>>> I noticed that the URL is malformed when launching using directly
>>> radosgw-agent -c <syncfile> but well formed when launching using
>>> service radosgw-agent start <syncfile>
>>>
>>> best regards
>>>
>>> -----Message d'origine-----
>>> De : alfredo.deza@inktank.com [mailto:alfredo.deza@inktank.com] De =
la
>>> part de Alfredo Deza Envoy=C3=A9 : lundi 2 f=C3=A9vrier 2015 15:18 =
=C3=80 :
>>> CHEVALIER Ghislain IMT/OLPS Cc : ceph-devel@vger.kernel.org Objet :=
 Re:
>>> [Ceph-devel] radosgw-agent failed to parse
>>>
>>> What version of the agent are you using? And when it fails, how doe=
s the log output look?
>>>
>>> On Mon, Feb 2, 2015 at 8:56 AM,  <ghislain.chevalier@orange.com> wr=
ote:
>>>> Hi all,
>>>>
>>>> Context : Ubuntu 14.04 TLS firefly 0.80.8
>>>>
>>>> I sent this post in ceph-users (identical subject) because I recen=
tly encountered the same issue.
>>>> Maybe I missed something between July and January...
>>>>
>>>> I found that the http request wasn't correctly formed by
>>>> /usr/lib/python2.7/dist-packages/radosgw_agent/client.py
>>>>
>>>> I did the changes below
>>>> #    url =3D '{protocol}://{host}{path}'.format(protocol=3Drequest=
=2Eprotocol,
>>>> #                                             host=3Drequest.host,
>>>> #                                             path=3Drequest.path)
>>>>      url =3D '{path}'.format(protocol=3D"", host=3D"", path=3Drequ=
est.path)
>>>>
>>>> The request is then correctly formed and sent.
>>>>
>>>> I still have problems setting the federation between 2 zones of 2 =
ceph clusters in 2 regions.
>>>>
>>>> I go on investigating.
>>>>
>>>> Best regards
>>>>
>>>>
>>>> __________________________________________________________________=
__
>>>> _ _ ___________________________________________________
>>>>
>>>> Ce message et ses pieces jointes peuvent contenir des informations
>>>> confidentielles ou privilegiees et ne doivent donc pas etre
>>>> diffuses, exploites ou copies sans autorisation. Si vous avez recu
>>>> ce message par erreur, veuillez le signaler a l'expediteur et le d=
etruire ainsi que les pieces jointes. Les messages electroniques etant =
susceptibles d'alteration, Orange decline toute responsabilite si ce me=
ssage a ete altere, deforme ou falsifie. Merci.
>>>>
>>>> This message and its attachments may contain confidential or
>>>> privileged information that may be protected by law; they should n=
ot be distributed, used or copied without authorisation.
>>>> If you have received this email in error, please notify the sender=
 and delete this message and its attachments.
>>>> As emails may be altered, Orange is not liable for messages that h=
ave been modified, changed or falsified.
>>>> Thank you.
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> ___________________________________________________________________=
__
>>> _ ___________________________________________________
>>>
>>> Ce message et ses pieces jointes peuvent contenir des informations
>>> confidentielles ou privilegiees et ne doivent donc pas etre diffuse=
s,
>>> exploites ou copies sans autorisation. Si vous avez recu ce message
>>> par erreur, veuillez le signaler a l'expediteur et le detruire ains=
i que les pieces jointes. Les messages electroniques etant susceptibles=
 d'alteration, Orange decline toute responsabilite si ce message a ete =
altere, deforme ou falsifie. Merci.
>>>
>>> This message and its attachments may contain confidential or
>>> privileged information that may be protected by law; they should no=
t be distributed, used or copied without authorisation.
>>> If you have received this email in error, please notify the sender =
and delete this message and its attachments.
>>> As emails may be altered, Orange is not liable for messages that ha=
ve been modified, changed or falsified.
>>> Thank you.
>>>
>>
>> ____________________________________________________________________=
__
>> ___________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations
>> confidentielles ou privilegiees et ne doivent donc pas etre diffuses=
,
>> exploites ou copies sans autorisation. Si vous avez recu ce message
>> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi=
 que les pieces jointes. Les messages electroniques etant susceptibles =
d'alteration, Orange decline toute responsabilite si ce message a ete a=
ltere, deforme ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or
>> privileged information that may be protected by law; they should not=
 be distributed, used or copied without authorisation.
>> If you have received this email in error, please notify the sender a=
nd delete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that hav=
e been modified, changed or falsified.
>> Thank you.
>>
>
> _____________________________________________________________________=
____________________________________________________
>
> Ce message et ses pieces jointes peuvent contenir des informations co=
nfidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous ave=
z recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messa=
ges electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, defor=
me ou falsifie. Merci.
>
> This message and its attachments may contain confidential or privileg=
ed information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
> Thank you.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
