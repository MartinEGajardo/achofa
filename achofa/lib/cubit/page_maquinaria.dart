import 'package:achofa/cubit/cubit_maquinaria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MaquinariaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maquinarias Agrícolas'),
      ),
      body: BlocProvider(
        create: (context) => MaquinariaCubit(),
        child: MaquinariaView(),
      ),
    );
  }
}

class MaquinariaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            context.read<MaquinariaCubit>().fetchMaquinarias(1, 10, value);
          },
          decoration: InputDecoration(
            labelText: 'Buscar',
          ),
        ),
        Expanded(
          child: BlocBuilder<MaquinariaCubit, MaquinariaState>(
            builder: (context, state) {
              if (state is MaquinariaLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MaquinariaLoaded) {
                if (state.maquinarias.isEmpty) {
                  return Center(child: Text('No hay maquinarias disponibles'));
                }
                return ListView.builder(
                  itemCount: state.maquinarias.length,
                  itemBuilder: (context, index) {
                    final maquinaria = state.maquinarias[index];
                    return ListTile(
                      title: Text(maquinaria.nombre),
                      subtitle: Text(maquinaria.descripcion),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<MaquinariaCubit>().deleteMaquinaria(maquinaria.id);
                        },
                      ),
                    );
                  },
                );
              } else if (state is MaquinariaError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
