From: Alex Litvak <alexander.v.litvak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: How to lower log verbosity
Date: Sun, 17 Mar 2019 10:16:24 -0500
Message-ID: <q6loc9$6qal$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello everyone,

As I am troubleshooting an issue I see logs literally littered with messages such as below.  I searched documentation and couldn't find a specific debug nob to turn.  I see some debugging is on by 
default but I don't need to see staff below especially mgr and client repeating.  Also I am not sure what the difference with memory vs file debug ratios.  Thanks in advance for any hint.


Mar 17 08:11:44 storage1n1-chi docker[13518]: audit 2019-03-17 08:11:43.045636 mgr.storage1n2-chi mgr.394322 10.1.40.62:0/19661 3377 : audit [DBG] from='client.320702 10.1.40.62:0/3859627195' 
entity='client.admin' cmd=[{"width": 80, "prefix": "iostat", "poll": true, "target": ["mgr", ""], "print_header": false}]: dispatch
Mar 17 08:11:44 storage1n1-chi docker[13518]: audit 2019-03-17 08:11:43.048607 mgr.storage1n2-chi mgr.394322 10.1.40.62:0/19661 3378 : audit [DBG] from='client.328541 10.1.40.62:0/748275798' 
entity='client.admin' cmd=[{"width": 80, "prefix": "iostat", "poll": true, "target": ["mgr", ""], "print_header": false}]: dispatch
Mar 17 08:11:44 storage1n1-chi docker[13518]: audit 2019-03-17 08:11:43.921762 mgr.storage1n2-chi mgr.394322 10.1.40.62:0/19661 3379 : audit [DBG] from='client.341603 10.1.40.62:0/535963786' 
entity='client.admin' cmd=[{"width": 80, "prefix": "iostat", "poll": true, "target": ["mgr", ""], "print_header": false}]: dispatch

Mar 17 08:11:25 storage1n1-chi bf695c816174[17083]: 2019-03-17 08:11:25.845 7fe9ddb4f700  1 mgr send_beacon standby
Mar 17 08:11:25 storage1n1-chi docker[13941]: 2019-03-17 08:11:25.845 7fe9ddb4f700  1 mgr send_beacon standby
Mar 17 08:11:27 storage1n1-chi bf695c816174[17083]: 2019-03-17 08:11:27.865 7fe9ddb4f700  1 mgr send_beacon standby
Mar 17 08:11:27 storage1n1-chi docker[13941]: 2019-03-17 08:11:27.865 7fe9ddb4f700  1 mgr send_beacon standby
Mar 17 08:11:29 storage1n1-chi bf695c816174[17083]: 2019-03-17 08:11:29.885 7fe9ddb4f700  1 mgr send_beacon standby
Mar 17 08:11:29 storage1n1-chi docker[13941]: 2019-03-17 08:11:29.885 7fe9ddb4f700  1 mgr send_beacon standby

Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27d16700  1 mgr.server reply handle_command (0) Success |  299 KiB/s |  122 KiB/s |  421 KiB/s |        306 |         17 
|        324 |
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  0 log_channel(audit) log [DBG] : from='client.320702 10.1.40.62:0/3859627195' entity='client.admin' 
cmd=[{"width": 80, "prefix": "iostat", "poll": true, "target": ["mgr", ""], "print_header": false}]: dispatch
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer status'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer mode'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer on'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer off'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer eval'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer eval-verbose'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer optimize'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer show'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer rm'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer reset'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer dump'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'balancer execute'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-login-credentials'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-session-expire'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard create-self-signed-cert'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-access-key'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-port'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-enable-browsable-api'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-port'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-admin-resource'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-secret-key'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-scheme'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-enable-browsable-api'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-user-id'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-admin-resource'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-access-key'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rest-requests-timeout'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-scheme'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-host'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rgw-api-user-id'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard get-rest-requests-timeout'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-host'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'dashboard set-rgw-api-secret-key'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'hello'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'influx config-set'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'influx config-show'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'influx send'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'influx self-test'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27515700  1 mgr.server handle_command pyc_prefix: 'iostat'
Mar 17 08:13:05 storage1n2-chi ecbe67c5b2e7[36572]: 2019-03-17 08:13:05.302 7f9c27d16700  1 mgr.server reply handle_command (0) Success |  299 KiB/s |  122 KiB/s |  421 KiB/s |        306 |         17 
|        324 |
^C
